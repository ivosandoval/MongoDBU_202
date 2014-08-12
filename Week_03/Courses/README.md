# Memory model in MongoDB

Voir FAQ: MongoDB Storage

Memory Mapped Files (MMAP)
Least Recently Used (LRU

C'est un adressage en m�moire virtuelle, le serveur charge les pages en m�moire virtuelle jusqu�) ce que la m�moire physique soit pleine et qu'il faille remplacer les pages marqu�es LRU

----

# Resident memory in MongoDB

Working set = partie des data qui est le plus acc�d�e :
* Index
* Sous ensemble de donn�es

----

# Working set vs resident memory

La m�moire r�sidente peut �tre plus importante que la m�moire de travail

	db.serverStatus({workingSet:1})

La taille d'une page m�moire par d�faut est de 4k nous pouvons donc en d�duire le working set grace � une multiplication de **workingSet**.
La taille du working set est une partie de la m�moire r�sidente dans **mem**

----

# Journaling's impact on resident memory

La m�moire r�sidente peut �tre moins importante que la m�moire de travail

...

----

# Process restarts

# Pre heating data

----

# Readahead

