In this problem, you will be causing a rollback scenario. Set up a replica set with one primary, one secondary, and an arbiter. Write some data to the primary in such a way that it does not replicate on the secondary (perhaps by taking down the secondary) then remove the primary from the replica set. Let the secondary come back up and become primary, write to it, and then bring up the original primary (it will now be a secondary).

Once you've triggered the rollback scenario, please submit your work using MongoProc. You do not need to reload the data lost during rollback. For your solution to be graded correct, you must have one secondary in the replica set on which rollback has occurred.

You must run mongoProc from the machine that experiences rollback. MongnoProc will look for the server at host='localhost' regardless of your settings, and you will need to direct it to the port that your primary is on.

Adam wrote a tutorial blog post on simulating rollback. It might be a little outdated, but provides a detailed discussion of this topic and is worth the read.

----

Create the directories
	mkdir p s a
	
Start the servers
	mongod --replSet m202 --logpath "p.log" --dbpath "/home/vagrant/Desktop/m202/HW4/p3" --port 27017 --smallfiles --oplogSize 64 --fork
	mongod --replSet m202 --logpath "s.log" --dbpath "/home/vagrant/Desktop/m202/HW4/s3" --port 27018 --smallfiles --oplogSize 64 --fork
	mongod --replSet m202 --logpath "a.log" --dbpath "/home/vagrant/Desktop/m202/HW4/a3" --port 27019 --smallfiles --oplogSize 64 --fork
	
Configure and test the replica from primary
	mongo --port 27017
	> rs.initialize()
	> rs.add("localhost:27018")
	> rs.addArb("localhost:27019")
	> rs.status()
	> use testDB
	> db.testColl.insert({"a":"a"})
	
Stop secondary
    ps -A | grep mongod
    sudo kill pid (on port 27018)

Insert on primary and stop
	> db.testColl.insert({"b":"b"})
    ps -A | grep mongod
    sudo kill pid (on port 27017)

Start and insert on secondary
	mongod --replSet m202 --logpath "s.log" --dbpath "/home/vagrant/Desktop/m202/HW4/s3" --port 27018 --smallfiles --oplogSize 64 --fork
	> use testDB
	> db.testColl.insert({"c":"c"})

Start primary
	mongod --replSet m202 --logpath "p.log" --dbpath "/home/vagrant/Desktop/m202/HW4/p3" --port 27017 --smallfiles --oplogSize 64 --fork

There's a rollback directory in the primary dbpath  
Use mongoproc after switching the ports in the configuration (weird bug)

Check the rollback operations
	 bsondump p3/rollback/testDB.testColl.2014-08-12T09-52-29.0.bson   