Spin up a server with --auth and create a user, "roland", who is a userAdminAnyDatabase and who logs in on the admin database with password "12345".

Create user "vespa" who can log into the "testA" database and who has the roles of "read" and "dbAdmin" on database "testA" and "readWrite" on database "testB". Do not give "vespa" any other abilities beyond this on any database. You may use any password you like for vespa.

You may point MongoProc to any host/port you like.

----

```bash
$ mkdir /data/F1
$ mongod --logpath /data/F1.log --dbpath /data/F1 --port 27017 --fork --smallfiles
$ mongo
> use admin
> show users
> db.createUser({ user: "siteUserAdmin", pwd: "password", roles: [{ role: "userAdminAnyDatabase", db: "admin" }]})
> db.runCommand({usersInfo:"siteUserAdmin", showPrivileges:true})
> show users
> db.shutdownServer()
$ mongod --logpath /data/F1.log --dbpath /data/F1 --port 27017 --fork --smallfiles --auth
$ mongo -u siteUserAdmin -p password --authenticationDatabase=admin
> use admin
> show users
> db.createUser({user:"roland", pwd: "12345", roles:[{role:"userAdminAnyDatabase", db:"admin"}]})
> db.runCommand({usersInfo:"roland", showPrivileges:true})
> use testA
> db.createUser({ user:"vespa", pwd: "12345", roles:[{ role: "read", db:"testA" },{ role: "dbAdmin", db: "testA" }, { role: "readWrite", db: "testB" }]})
> db.runCommand({usersInfo:"vespa", showPrivileges:true})
> show users
