In this problem we will emulate a data management strategy in which we periodically move data from short-term storage (STS) to long-term storage (LTS). We have implemented this strategy using tag-based sharding.

Start by spinning up a sharded cluster as follows:

```
$ mongo --nodb
> config = { d0 : { smallfiles : "", noprealloc : "", nopreallocj : ""}, d1 : { smallfiles : "", noprealloc : "", nopreallocj : "" }, d2 : { smallfiles : "", noprealloc : "", nopreallocj : ""}};
> cluster = new ShardingTest( { shards : config } );
```

This will create 3 standalone shards on ports 30000, 30001, and 30002, as well as a mongos on port 30999. The config portion of the above will eliminate the disk space issues some students have seen when using ShardingTest.

Next, initialize the data in this cluster using MongoProc. You can choose the host you're pointing to, but MongoProc will be looking for the mongos at port 30999.

Following initialization, your system will contain the collection testDB.testColl. Once initial balancing completes, all documents in this collection with a createdDate field value that falls any time in the year 2013 are in LTS and all documents created in 2014 are in STS. There are two shards used for LTS and one shard for STS.

Your assignment is to move all data for the month of January 2014 into LTS as part of periodic maintenance. For this problem we are pretty sure you can "solve" it in a couple of ways that are not ideal. In an ideal solution you will make the balancer do the work for you. Please note that the balancer must be running when you turn in your solution.

----

sh.stopBalancer()
sh.status()
db.tags.find()
db.tags.remove({ "_id" : { "ns" : "testDB.testColl", "min" : { "createdDate" : ISODate("2013-10-01T00:00:00Z") } }, "max" : { "createdDate" : ISODate("2014-01-01T00:00:00Z") }, "ns" : "testDB.testColl", "tag" : "LTS", "min" : { "createdDate" : ISODate("2013-10-01T00:00:00Z") } })
db.tags.remove({ "_id" : { "ns" : "testDB.testColl", "min" : { "createdDate" : ISODate("2014-01-01T00:00:00Z") } }, "max" : { "createdDate" : ISODate("2014-05-01T00:00:00Z") }, "ns" : "testDB.testColl", "tag" : "STS", "min" : { "createdDate" : ISODate("2014-01-01T00:00:00Z") } })
sh.addTagRange('testDB.testColl', {createdDate : ISODate("2013-01-01")}, {createdDate : ISODate("2014-02-01")}, "LTS")
sh.addTagRange('testDB.testColl', {createdDate : ISODate("2014-02-01")}, {createdDate : ISODate("2014-05-01")}, "STS")
sh.status()
sh.startBalancer()
sh.status()
