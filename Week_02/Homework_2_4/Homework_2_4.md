Over time a MongoDB database can become fragmented and cause reduced storage efficiency.

In this problem we have provided you with an already fragmented database. You will want to extract the handout and set your mongod's dbpath to the extracted 'fragDB' directory. You'll be working with the fragDB database, and the fragColl collection.

Your goal in this homework is to increase storage efficiency and reclaim disk space. You may use any method learned thus far to accomplish this goal. However, please do not tamper (remove/update/insert) with the documents in the database given, apart from querying the database to find out more information about the fragmented components.

You are encouraged to use MongoProc to continuously test your progress until you are ready to grade the homework.

Useful Formulas

    Collection Storage Efficiency:

    db.fragColl.stats().size/db.fragColl.stats().storageSize

    Database Storage Efficiency:

    (db.stats().dataSize + db.stats().indexSize) / db.stats().fileSize

----

	use FragDB
	db.repairDatabase()