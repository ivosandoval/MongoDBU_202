In this problem, you will be examining a log file with mtools to determine what is causing problems.

First, download and unpack the handout.

Determine the namespace and query shape (called the "pattern" by mtools) that the server has cumulatively spent the most time working on. You'll want to use mloginfo for this step. To help ensure that you're on the right track, this will be the query shape that has taken, cumulatively, 2038017 ms of operation time in this log file, or a little under 34 minutes.

Unless you are already familiar with mloginfo, you may want to examine the docs.

When you have your query shape (it'll be in the "pattern" column), paste it below:

----

```bash
$ mloginfo /home/vagrant/Desktop/m202/Final/question_6_examining_a_log_file_with_mtools/m202_final_6-8.log --queries
     source: /home/vagrant/Desktop/m202/Final/question_6_examining_a_log_file_with_mtools/m202_final_6-8.log
      start: 2014 Jun 21 00:11:00
        end: 2014 Jun 21 00:12:59
date format: iso8601-utc
     length: 174406
     binary: unknown
    version: >= 2.6 (iso8601 format)

QUERIES


namespace                            pattern                                                                        count    min (ms)    max (ms)    mean (ms)    95%-ile (ms)    sum (ms)

grilled.indigo.papaya                {"_id": 1, "l": {"$not": 1}}                                                    4227           0        3872          482          1189.4     2038017
grilled.indigo.papaya                {"_id": 1}                                                                     16877           0        2557           42           343.2      725607
grilled.indigo.grapefruit            {"_id": 1}                                                                      1170           0        2516          479         1196.85      560682
grilled.indigo.salal.berry           {"clusterId": 1}                                                                1625           0        2805          260          1016.6      423831
grilled.indigo.tangerine             {"_id": 1}                                                                       380           0        3037          484          1144.2      184188
```
```json
{"_id": 1, "l": {"$not": 1}}
```
