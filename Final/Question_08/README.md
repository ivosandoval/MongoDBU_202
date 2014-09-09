For this problem, start over with your original, unfiltered log file. It has been included again as a handout for your convenience.

The log file has an event where there was a sharp spike in incoming connections. Use mplotqueries to plot a chart that shows the connection churn in one-second intervals (buckets). Find the exact second when this connection spike begins. If you click on the first green bar of the connection spike, you can read the time printed in the shell. You can also zoom in close enough to read the second at the x-axis.

Once you've found the start of the spike, use mlogfilter to slice out a time windows from the log file, beginning at the time you found, and lasting 5 seconds. Store the matching log lines in a temporary file (by appending > tempfile.log ), or pipe it to the next command.

Use mplotqueries to create a scatter plot of the 5-second log window. Look at that highest spike you see. Click on some of the operations to get details in the shell.

What is the write concern of these operations?
* { w : 0 }
* { w : 1 }
* { w : 2 }
* { w : 3 }
* { w : 'majority' }
* { j : true }

----

```bash
$ mplotqueries 8.log --type connchurn -b 1
```
We can see a spike beginning around Jun 21 00:11:34 or 35

```bash
$ mlogfilter 8.log --from Jun 21 00:11:35 --to Jun 21 00:11:40 > 8a.log
$ mplotqueries /home/vagrant/Desktop/m202/Final/8.log --type scatter
2014-06-21T00:11:37.661Z [conn694] command grilled.$cmd command: update { update: "CyaHAMUebYaZepepwIpHEvBlkDt", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "GnoA2cQk7b8wYVYoxjaYR7" }, u: { $set: { queueSize: 0, lastUpdate: new Date(1403309485526) } }, upsert: true } ] } keyUpdates:0 numYields:0 reslen:95 2087ms
2014-06-21T00:11:37.661Z [conn619] command grilled.$cmd command: update { update: "uionJBQboEga25", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "5tCrmNbxxKXPRLBl1BBRXqDCkZRigUubKH" }, u: { $pull: { uptimes: { recorded: { $lte: new Date(1403308699816) } } } } } ] } keyUpdates:0 numYields:0 reslen:95 2125ms
2014-06-21T00:11:37.662Z [conn597] command grilled.$cmd command: update { update: "Ojwt5jMtWpPMwaJzNp3jOwCTU2P", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "hx3lsiVS1yyUJekyDsERIf" }, u: { $set: { queueSize: 9000, lastUpdate: new Date(1403309486557) } }, upsert: true } ] } keyUpdates:0 numYields:0 reslen:95 2114ms
2014-06-21T00:11:37.661Z [conn666] command grilled.$cmd command: update { update: "0PqjKrW57alwFcdwZp71BUYFDFA", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "JnyEV7QiPstUf7u1JuLurd" }, u: { $set: { queueSize: 0, lastUpdate: new Date(1403309486462) } }, upsert: true } ] } keyUpdates:0 numYields:0 reslen:95 2125ms
2014-06-21T00:11:37.662Z [conn690] command grilled.$cmd command: insert { insert: "hYNec3ufFRZ3HvSWH2Q5eKQo", ordered: true, writeConcern: { w: 2 }, documents: [ { _id: ObjectId('53a4cdb7e4b0715a218921ff'), hostname: "WtwbjO6jpvrBP5cWdkZ", port: 27030, connectTime: 1, cmdTime: 3, success: true, created: new Date(1403309486635), source: "rnZH5TATkEmcxDs0XVrB" } ] } keyUpdates:0 numYields:0 locks(micros) w:112 reslen:80 2107ms
2014-06-21T00:11:37.662Z [conn831] command grilled.$cmd command: update { update: "UIgRy540Z6EEJ5jBHUVOSZzJjWW", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "U0WyMxPZRG9kq6bNF9qENu" }, u: { $set: { queueSize: 0, lastUpdate: new Date(1403309485628) } }, upsert: true } ] } keyUpdates:0 numYields:0 reslen:95 1962ms
2014-06-21T00:11:37.662Z [conn727] command grilled.$cmd command: update { update: "XEZppLE6ccuDhEcJ5EUSRdlnDvI", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "QXIuLOthBiqgVawRChCbrE" }, u: { $set: { queueSize: 0, lastUpdate: new Date(1403309487117) } }, upsert: true } ] } keyUpdates:0 numYields:0 reslen:95 1607ms
2014-06-21T00:11:37.661Z [conn1079] command grilled.$cmd command: update { update: "3Aka1fPgzYJvwnG1DtNsEYM1Hrp", ordered: true, writeConcern: { w: 2 }, updates: [ { q: { _id: "H1ZZvHN7mYU8UNEiXn04X9" }, u: { $set: { queueSize: 9000, lastUpdate: new Date(1403309486710) } }, upsert: true } ] } keyUpdates:0 numYields:0 reslen:95 1096ms
```

* { w : 2 }
