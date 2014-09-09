This problem requires you to upgrade matplotlib for mtools' mplotqueries script. As it currently exists, mplotqueries is using on older version of matplotlib, and upgrading it will require a few steps.

Perform the following steps in order (you will need to confirm after each one):

```bash
sudo pip uninstall mtools
sudo pip uninstall matplotlib
sudo apt-get install libpng-dev libjpeg8-dev libfreetype6-dev
sudo apt-get install build-essential
sudo easy_install -U distribute
sudo pip install matplotlib
sudo pip install mtools
```

Once you've got the namespace and query shape from the previous problem, use mlogfilter to filter the log file to get only those queries that match these, and then use mplotqueries to look at the queries in one-second buckets. To make sure you're doing things right, your results should look like this:

Your results will have their axes labeled. Examine the highest peak. You can either compare it to the y-axis, or click on it to find out the value.

Your question is this: What is the number of these operations during that one-second bin with the highest peak?

_Hint: If you're unfamiliar with the bash commands, you might want, as an intermediate step, to create a new log file. By default, mlogfilter sends its results to stdout, but you can redirect it to a new file by appending `> newfile_name` to the end of the command._
* 60-90 ops/s
* 120-180 ops/s
* 300-450 ops/s
* 600-900 ops/s
* 1200-1800 ops/s
----

```bash
$ mlogfilter /home/vagrant/Desktop/m202/Final/7.log --namespace grilled.indigo.papaya > /home/vagrant/Desktop/m202/Final/7a.log
$ grep '\$not' /home/vagrant/Desktop/m202/Final/7a.log > /home/vagrant/Desktop/m202/Final/7b.log
$ mplotqueries /home/vagrant/Desktop/m202/Final/7b.log --type histogram --group pattern -b 1
  87 {"_id": 1, "l": {"$not": 1}} events in 1 sec beginning at Jun 21 00:12:36
```

* 60-90 ops/s
