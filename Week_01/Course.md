MMS: Understanding ulimits
==========================

L'alerte **low ulimit** vient dune limitation trop restrictive du système qui se configure via ulimits.
Les valeurs configurées sont visibles via *ulimits -a* et configurables via les switchs proposés.
L'alerte **low ulimit** est généralement dûe au switch *-n* (file descriptors) qui est trop bas.
  Sur Linux le défaut est 1024, trop peu pour un environnement de production, il faut passer la valeur à celle recommandée dans la doc sachant qu'une instance est hardcodée à 20000 fichiers ouverts.


MMS: Increasing the ulimit for a specific process
=================================================

On vérifie dans un premier temps les process mongo qui tournent

    ps aux | grep mongo
    cat /proc/5410/limits
