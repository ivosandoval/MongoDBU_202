Suppose you have a sharded collection final_exam.m202 in a cluster with 3 shards. To set up the problem, first initialize a cluster with 3 single-server shards (not replica sets) in the mongo shell using ShardingTest:

```
$ mongo --nodb
> config = { d0 : { smallfiles : "", noprealloc : "", nopreallocj : ""}, d1 : { smallfiles : "", noprealloc : "", nopreallocj : "" }, d2 : { smallfiles : "", noprealloc : "", nopreallocj : ""}};
> cluster = new ShardingTest( { shards : config } );
```

Then click "Initialize" in MongoProc, which will verify that you have 3 shards and then insert test data into `final_exam.m202`.

Unfortunately, even though your shard key `{otherID: 1}` has high cardinality, the data is not being distributed well among the shards. You have decided that a hashed shard key based on the `_id` field would be a better choice, and want to reconfigure the collection to use this new shard key. Once you have the cluster using the new shard key for `final_exam.m202`, test in MongoProc and turn in when correct.

----

```bash
$ mongo --port 30999
```
```javascript
> sh.status()
--- Sharding Status ---
sharding version: {
    "_id" : 1,
    "version" : 4,
    "minCompatibleVersion" : 4,
    "currentVersion" : 5,
    "clusterId" : ObjectId("539dc10ba86a01d284354f4c")
}
shards:
    { "_id" : "shard0000", "host" : "localhost:30000" }
    { "_id" : "shard0001", "host" : "localhost:30001" }
    { "_id" : "shard0002", "host" : "localhost:30002" }
databases:
    { "_id" : "admin", "partitioned" : false, "primary" : "config" }
    { "_id" : "final_exam", "partitioned" : true, "primary" : "shard0001" }
        final_exam.m202
            shard key: { "otherID" : 1 }
            chunks:
                shard0000 1
                shard0002 1
                shard0001 1
            { "otherID" : { "$minKey" : 1 } } -->> { "otherID" : -1 } on : shard0000 Timestamp(2, 0)
            { "otherID" : -1 } -->> { "otherID" : 999 } on : shard0002 Timestamp(3, 0)
            { "otherID" : 999 } -->> { "otherID" : { "$maxKey" : 1 } } on : shard0001 Timestamp(3, 1)
> show databases;
admin (empty)
config 0.016GB
final_exam 0.156GB
> use final_exam
> show collections
m202
system.indexes
> db.system.indexes.find()
{ "v" : 1, "key" : { "_id" : 1 }, "name" : "_id_", "ns" : "final_exam.m202" }
{ "v" : 1, "key" : { "otherID" : 1 }, "name" : "otherID_1", "ns" : "final_exam.m202" }
```

Dump all data from mongos
```bash
$ mkdir tmp_7
$ mongodump --db final_exam --collection m202 --port 30999
```

Drop the sharded collection mongo --port 30999
```javascript
> db.m202.drop()
```

Restore the dumped data
```bash
$ mongorestore --db final_exam --port 30999 dump/final_exam/
```

Create the new hashed shard key
```javascript
> sh.status()
--- Sharding Status ---
sharding version: {
    "_id" : 1,
    "version" : 4,
    "minCompatibleVersion" : 4,
    "currentVersion" : 5,
    "clusterId" : ObjectId("539dc10ba86a01d284354f4c")
}
    shards:
        { "_id" : "shard0000", "host" : "localhost:30000" }
        { "_id" : "shard0001", "host" : "localhost:30001" }
        { "_id" : "shard0002", "host" : "localhost:30002" }
    databases:
        { "_id" : "admin", "partitioned" : false, "primary" : "config" }
        { "_id" : "final_exam", "partitioned" : true, "primary" : "shard0001" }
> db.m202.findOne()
{
    "_id" : ObjectId("539dc11ee6fc8c69afb09d0a"),
    "otherID" : 999,
    "ts" : ISODate("2014-07-01T00:00:01.998Z")
}
> db.m202.ensureIndex({"_id":"hashed"})
> sh.shardCollection( "final_exam.m202", { _id: "hashed" } )
> sh.status()
--- Sharding Status ---
sharding version: {
    "_id" : 1,
    "version" : 4,
    "minCompatibleVersion" : 4,
    "currentVersion" : 5,
    "clusterId" : ObjectId("539dc10ba86a01d284354f4c")
}
    shards:
        { "_id" : "shard0000", "host" : "localhost:30000" }
        { "_id" : "shard0001", "host" : "localhost:30001" }
        { "_id" : "shard0002", "host" : "localhost:30002" }
    databases:
        { "_id" : "admin", "partitioned" : false, "primary" : "config" }
        { "_id" : "final_exam", "partitioned" : true, "primary" : "shard0001" }
        final_exam.m202
            shard key: { "_id" : "hashed" }
            chunks:
                shard0001 1
            { "_id" : { "$minKey" : 1 } } -->> { "_id" : { "$maxKey" : 1 } } on : shard0001 Timestamp(1, 0)
```
