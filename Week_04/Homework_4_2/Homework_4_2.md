Suppose you have an application on which you want to run analytics monthly. The analytics require an index and for performance reasons you will create the index on a secondary. Initiate a replica set with a primary and only one secondary. Create an index on the secondary only. The index should be on the "a" field of the "testDB.testColl" collection.

When you have created the index on the secondary, test with MongoProc to be sure you've completed the problem correctly and then submit.

Note: If you have any documents in the testDB.testColl collection when you test or submit with MongoProc they will be removed.

----

Create the directories
	mkdir p s a
	
Start the servers
	mongod --replSet m202 --logpath "p.log" --dbpath p --port 27017 --smallfiles --oplogSize 64 --fork
	mongod --replSet m202 --logpath "s.log" --dbpath s --port 27018 --smallfiles --oplogSize 64 --fork
	mongod --replSet m202 --logpath "a.log" --dbpath a --port 27019 --smallfiles --oplogSize 64 --fork
	
Configure and test the replica from primary
	mongo --port 27017
	> rs.initialize()
	> rs.add("localhost:27018")
	> rs.addArb("localhost:27019")
	> rs.status()
	> use testDB
	> db.testColl.insert({"a":"a"})
	> db.testColl.remove({"a":"a"})

Stop the secondary
    ps -A | grep mongod
    sudo kill pid (on port 27018)

Manipulate the secondary in standalone mode
    mongod --logpath "2.log" --dbpath 2 --port 27018 --smallfiles --oplogSize 64 --fork
    mongo --port 27018
    > use testDB
    > db.testColl.ensureIndex({"a" : 1})
    > db.system.indexes.find()

Stop the secondary
    ps -A | grep mongod
    sudo kill pid (on port 27018)

Start secondary in replica
	mongod --replSet m202 --logpath "s.log" --dbpath s --port 27018 --smallfiles --oplogSize 64 --fork