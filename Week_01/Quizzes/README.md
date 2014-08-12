# MMS: Agent best practices

How many MMS monitoring agents should you run for a production system?

    More than 1 

----

# MMS: Understanding ulimits

What is typically the cause of a low ulimit warning in MMS monitoring?

    The resources available to mongod may be too limited. 

----

# MMS: Hardware monitoring with munin mode

Based solely on the following graph, which of the statements below are most likely to be true? Select 2.

    The server restarted 
    A relatively large number of writes occurred

----

# MMS: Stats that are usually correlated

Based solely on the graphs below, which of the following is most likely to be true?

    The working set can be contained in memory

Below are several groupings for stats you can view in MMS monitoring. Select those groups containing stats that are usually correlated with one another.

    opcounters, lock% 
    lock%, journal stats, flush average 
    non-mapped virtual memory, connections 
    cursors, connections 

----

# MMS: Replica sets

What do you see when you click on a replica set name and enter the replica set view?

	All servers in the replica set 

----

# MMS: State transitions in replica sets

Which sequence of events below does the following graph depict?

	restart, transition to primary, transition to secondary, restart 

----

# MMS: Replication lag and opcounters

Based solely on the following MMS monitoring view, which of the statements below is unlikely to be true?

	This application receives an extremely high volume of writes. 

----

# MMS: The effect of replication on opcounters

Extrapolating from this lesson, which of the following might cause different members of a replica set to have different opcounter values? Check all that apply.

	You are reading only from the primary.
	You have read preference set to secondaryPreferred.
	The primary will receive reads from each secondary as they read the oplog.

----

# MMS: Host recovering alerts

Which of the following will generate a host down alert? Check all that apply.

	A mongod process monitored by the agent is killed.
	A secondary in a replica set goes down. 
	An arbiter in a replica set goes down. 

----

# MMS: Administration

How can you add users to a group? Check all that apply.

	You can send email invitations to users who are not in MMS 
	You can add existing MMS users to groups yourself 
	You can add anyone with MongoDB Jira credentials yourself 

----

# Interpreting mongostat output

Consider the following output from mongostat:
```
insert  query update delete getmore command flushes mapped  vsize    res faults  locked db idx miss %     qr|qw   ar|aw  netIn netOut  conn set repl       time 
    *0    202     *0     *0       0    16|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    12k    21k    14  s1  PRI   20:35:15 
    *0    213     *0     *0       0     1|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    11k    11k    14  s1  PRI   20:35:16 
    *0    234     *0     *0       0     3|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    13k    12k    14  s1  PRI   20:35:17 
    *0    242     *0     *0       1     1|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     1|0    13k    12k    14  s1  PRI   20:35:18 
    *0    226     *0     *0       0     3|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    13k    12k    14  s1  PRI   20:35:19 
    *0    227     *0     *0       0     1|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     1|0    12k    11k    14  s1  PRI   20:35:20 
    *0    240     *0     *0       0     3|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     1|0    13k    12k    14  s1  PRI   20:35:21 
    *0    213     *0     *0       0     9|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    12k    18k    14  s1  PRI   20:35:22 
    *0    192     *0     *0       1     3|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    11k    10k    14  s1  PRI   20:35:23 
    *0    216     *0     *0       0     1|0       0  1.23g  3.11g   823m      0  test:0.0%          0       0|0     0|0    12k    11k    14  s1  PRI   20:35:24 
```
Which of the following statements is true?

	The data set is staying the same size. 

----

# netstat and iostat

If a disk was highly utilized and struggling to keep up, which CPU-level statistic would you expect to see increased?

	%iowait 

----

# db.serverStatus

Which of the following is NOT true of db.serverStatus?

	It tells you the names of hidden replica set members. 