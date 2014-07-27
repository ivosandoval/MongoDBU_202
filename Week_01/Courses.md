# MMS: Understanding ulimits

L'alerte **low ulimit** vient dune limitation trop restrictive du système qui se configure via ulimits.  
Les valeurs configurées sont visibles via **ulimits -a** et configurables via les switchs proposés.  
L'alerte **low ulimit** est généralement dûe au switch **-n** (file descriptors) qui est trop bas.  
        Sur Linux le défaut est 1024, trop peu pour un environnement de production, il faut passer la valeur à celle recommandée dans la doc sachant qu'une instance est hardcodée à 20000 fichiers ouverts.

----

# MMS: Increasing the ulimit for a specific process

On vérifie dans un premier temps les process mongo qui tournent :
```Shell
ps aux | grep mongo
cat /proc/5410/limits
```

On peut ensuite modifier l'information : 
```Shell
sudo vim /etc/init.d/mongod
    > ulimit -n 12000
sudo service mongod restart
```
----

# MMS: Setting the ulimit for the mongod user permanently

Les limites restent le défaut pour l'utilisateur **mongod** qui est celui qui fait tourner les démons. C'est donc pour lui qu'il faut faire les changements qui seront effectifs après un reboot.
```Shell
sudo su -s /bin/sh/ -c 'ulimit -a' mongod
vim /etc/security/limits.conf
    > mongod   -   nofiles   64000
```

----

# MMS: Hardware monitoring with munin mode

Il faut installer munin (http://mms.mongodb.com/help/tutorial/configure-monitoring/) et le démarrer pour avoir les stats hardware.
```Shell
sudo service munin-node start
```

----

# MMS: Stats that are usually correlated

* opcounters, lock%  
  opcounters : Les opérations sur le serveur (insert, delete, …)  
* Connections et mémoire non mappée  
  *non-mapped virtual memory* : mémoire utilisé par Mongo pour autre chose que les données, l'interpreteur javascript par exemple ou des tris sur la mémoire  
  *connections* : Un pic de connexions engendre un pic sur **non-mapped virtual memory**  
* Connections et curseurs/network
* Lock % et background flush avg
* Repl lag

----

# MMS: State transitions in replica sets

Purple bar = Le serveur devient un primaire  
Yellow bar = Le serveur devient un secondaire  
Red bar = Redemarrage

----

# MMS: Replication lag and opcounters

opcounters
opcounters repl
repl lag
replication oplog window = le temps max avant une resynchro complète

----

# MMS: The effect of replication on opcounters

	db.coll.remove({}) = 1 delete op se multiplie suivant le nombre de documents à supprimer

Il n'y a pas de relation directe entre les op et les op répliquées mais ça peut indiquer ce qui se passer en réalité (1 opération se répliquant un certain nombre de fois à cause des documents)

----

# MMS: Alert configuration basics

http://www.mongodb.com/blog/post/five-mms-monitoring-alerts-keep-your-mongodb-deployment-track

----

# mongostat HOWTO

## Pourquoi l'utiliser ?
Pour la fréquence de requêtage et les infos en temps réel

## Désavantages
* Lancement manuel
* Dur à déchiffrer
* Difficile de repérer des tendances

----

# Interpreting mongostat output

----

# netstat and iostat

----

# db.serverStatus

Il résume une grosse partie des compteurs qui sont récupérés dans MMS  
Il indique également si le serveur est lent avec une ensemble de métriques réduit qui peut permettre de déterminer le moment du ralentissement