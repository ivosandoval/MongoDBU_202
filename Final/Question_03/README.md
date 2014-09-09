Suppose you have a 3 node replica set where 2 of the nodes are in a data center that goes down and stays down indefinitely. Your job is to bring your third server to a place where it can accept writes.

For this problem, we'll only need a replica set.

Start by running the following lines and waiting for each to complete.

**Note:** You must wait for rst.startSet() to finish before executing rst.initiate(). You will know when it is finished when the log shows: "[rsStart] replSet can't get local.system.replset config from self or any seed (EMPTYCONFIG)".

If you are seeing log messages appear you can still paste in each command.

```bash
$ mongo --nodb
> options = {
    nodes: 3,
    startPort: 27017,
    nodeOptions: {
        smallfiles: "",
        noprealloc: "",
        nopreallocj: ""
    }
};
> rst = new ReplSetTest(options);
> rst.startSet();
> rst.initiate();
```

Then click "Initialize" in MongoProc. This will tear down the servers on ports 27018 and 27019. Your job is to get the server on 27017 up, running, and able to receive writes.

----

Remove all non primary members

```bash
$ mongo --port 27017
> rs.remove("localhost:27018")
> rs.remove("localhost:27019")
```
