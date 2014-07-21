You must complete Homework 1.1 before doing this problem.

Click the "Initialize" button in MongoProc to begin generating data for MMS. Clicking "Initialize" will cause a script to run that will insert and delete documents in the homework_1_2 collection of the m202 database (on the host you set up for Homework 1.1). Let this run for approximately 2 hours.

After 2 hours, look at your MMS Monitoring console and determine how many inserts per second there are for your host. Please use a resolution of 1 hour. At higher resolutions the data will jump around too much for you to see the average value.

When there is enough data for you to determine an answer, insert a document into the answers collection of the m202 database. The document you insert should have the following form:

{ "homework" : "homework_1.2", "answer" : 12313 }

The value for the answer field in this document should be the number of inserts per second for your host. Please be aware that your answer may not be the same as that for other students. Validation for this problem accounts for such differences. 

    10.85
