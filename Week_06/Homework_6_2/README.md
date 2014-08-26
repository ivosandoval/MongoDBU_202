In this problem, you have a cluster with 2 shards, each with a similar volume of data, but all the application traffic is going to one shard. You must diagnose the query pattern that is causing this problem and figure out how to balance out the traffic.

To set up the scenario, run the following commands to set up your cluster. The config document passed to ShardingTest will eliminate the disk space issues some students have seen when using ShardingTest.

```
$ mongo --nodb
> config = { d0 : { smallfiles : "", noprealloc : "", nopreallocj : ""}, d1 : { smallfiles : "", noprealloc : "", nopreallocj : "" } };
> cluster = new ShardingTest( { shards: config } );
```
Once the cluster is up, click "Initialize" in MongoProc one time to finish setting up the cluster's data and configuration. If you are running MongoProc on a machine other than the one running the mongos, then you must change the host of 'mongod1' in the settings. The host should be the hostname or IP of the machine on which the mongos is running. MongoProc will use port 30999 to connect to the mongos for this problem.

Once the cluster is initialized, click the "Initialize" button in MongoProc again to simulate application traffic to the cluster for 1 minute. You may click "Initialize" as many times as you like to simulate more traffic for 1 minute at a time. If you need to begin the problem again and want MongoProc to reinitialize the dataset, drop the week6 database from the cluster and click "Initialize" in MongoProc.

Use diagnostic tools (e.g., mongostat and the database profiler) to determine why all application traffic is being routed to one shard. Once you believe you have fixed the problem and traffic is balanced evenly between the two shards, test using MongoProc and then turn in if the test completes successfully.

----

On each shard

    db.setProfilingLevel(2)
    use week6
    db.system.profile.find().sort({"ts":-1})
    db.system.profile.find().sort({"$natural":-1}).limit(5).pretty()

On peut voir des updates sur _id" : { "$gte" : ISODate("2014-07-13T00:00:00Z"), "$lt" : ISODate("2014-07-19T00:00:00Z")} or les chunks associés sont tous sur shard0000

    sh.stopBalancer()
    db.runCommand( { moveChunk : "week6.m202", bounds : [{"_id": ISODate("2014-07-16T00:00:00Z")},{"_id": ISODate("2014-07-17T00:00:00Z")}],"to":"shard0001"})
    db.runCommand( { moveChunk : "week6.m202", bounds : [{"_id": ISODate("2014-07-17T00:00:00Z")},{"_id": ISODate("2014-07-18T00:00:00Z")}],"to":"shard0001"})
    db.runCommand( { moveChunk : "week6.m202", bounds : [{"_id": ISODate("2014-07-18T00:00:00Z")},{"_id": ISODate("2014-07-19T00:00:00Z")}],"to":"shard0001"})
