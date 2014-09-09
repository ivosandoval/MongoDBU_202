In this assignment, you will fix a problem that sometimes arises with config servers in a sharded cluster.

Start by running:

```bash
$ mongo --nodb
> cluster = new ShardingTest( { shards: 1 , rs : { nodes : [ { } ] }, config : 3 } )
```

Next, click the "Initialize" button in MongoProc. This will create the problem you will need to fix.

You can see the issue if you try to split a chunk in the 'testDB.testColl' collection with:

```javascript
db.adminCommand( { split : "testDB.testColl", middle : { _id : 7 } } )
```

This will fail. Your job is to track down the problem and solve it. When you think you've got it, test it with MongoProc and submit when finished.

*Hint: You will almost certainly need to spin up your own config server separately from the ShardingTest. **Make sure you use all of the same parameters used by ShardingTest when starting config servers.** You can see these parameters by typing `ps ax | grep mongo` in a Linux shell.*

----

```bash
$ mongo --port 29000
> use config
> db.command("dbhash")

$ mongo --port 29001
> use config
> db.command("dbhash")

$ mongo --port 29002
> use config
> db.command("dbhash")
```

29002 is desynchronized, we have to reset its data and sync it from an ok server before restarting them
```bash
$ mongo --port 29001
> use admin
> db.shutdownServer()

$ mongo --port 29002
> use admin
> db.shutdownServer()

$ rm -rf /data/db/test-config1
$ rsync -az /data/db/test-config2/ /data/db/test-config1/

$ mongod --port 29001 --dbpath /data/db/test-config1 --configsvr --setParameter enableTestCommands=1 --fork
$ mongod --port 29001 --dbpath /data/db/test-config2 --configsvr --setParameter enableTestCommands=1 --fork
```
