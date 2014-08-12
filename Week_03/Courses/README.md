# Memory model in MongoDB

Voir FAQ: MongoDB Storage

Memory Mapped Files (MMAP)
Least Recently Used (LRU

C'est un adressage en mémoire virtuelle, le serveur charge les pages en mémoire virtuelle jusqué) ce que la mémoire physique soit pleine et qu'il faille remplacer les pages marquées LRU

----

# Resident memory in MongoDB

Working set = partie des data qui est le plus accédée :
* Index
* Sous ensemble de données

----

# Working set vs resident memory

La mémoire résidente peut être plus importante que la mémoire de travail

	db.serverStatus({workingSet:1})

La taille d'une page mémoire par défaut est de 4k nous pouvons donc en déduire le working set grace à une multiplication de **workingSet**.
La taille du working set est une partie de la mémoire résidente dans **mem**

----

# Journaling's impact on resident memory

La mémoire résidente peut être moins importante que la mémoire de travail

...

----

# Process restarts

# Pre heating data

----

# Readahead

