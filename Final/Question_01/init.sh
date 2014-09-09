mkdir /data/F1
mongod --logpath /data/F1.log --dbpath /data/F1 --port 27017 --fork --smallfiles

sleep 5

mongo << 'EOF'
use admin
db.createUser({ user: "siteUserAdmin", pwd: "password", roles: [{ role: "userAdminAnyDatabase", db: "admin" }]})
EOF

killall mongod
mongod --logpath /data/F1.log --dbpath /data/F1 --port 27017 --fork --smallfiles --auth

mongo -u siteUserAdmin -p password --authenticationDatabase=admin << 'EOF'
use admin
db.createUser({user:"roland", pwd: "12345", roles:[{role:"userAdminAnyDatabase", db:"admin"}]})
use testA
db.createUser({ user:"vespa", pwd: "12345", roles:[{ role: "read", db:"testA" },{ role: "dbAdmin", db: "testA" }, { role: "readWrite", db: "testB" }]})
EOF

# commandes utiles pour vérifications
# show users
# rs.status()
# db.runCommand({usersInfo:"siteUserAdmin", showPrivileges:true})
# db.runCommand({usersInfo:"vespa", showPrivileges:true})
# db.runCommand({usersInfo:"roland", showPrivileges:true})
