  ___                                          ______                      _
 / _ \                                         | ___ \                    | |
/ /_\ \_      _____  ___  ___  _ __ ___   ___  | |_/ /___ _ __   ___  _ __| |_
|  _  \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ |    // _ \ '_ \ / _ \| '__| __|
| | | |\ V  V /  __/\__ \ (_) | | | | | |  __/ | |\ \  __/ |_) | (_) | |  | |_
\_| |_/ \_/\_/ \___||___/\___/|_| |_| |_|\___| \_| \_\___| .__/ \___/|_|   \__|
                                                         | |
                                                         |_|

## DESCRIPTION

Create awesome report in json format from raw data like:

```
user,0,Leida,Cira,0
session,0,0,Safari 29,87,2016-10-23
session,0,1,Firefox 12,118,2017-02-27
session,0,2,Internet Explorer 28,31,2017-03-28
session,0,3,Internet Explorer 28,109,2016-09-15
session,0,4,Safari 39,104,2017-09-27
session,0,5,Internet Explorer 35,6,2016-09-01
user,1,Palmer,Katrina,65
session,1,0,Safari 17,12,2016-10-21
session,1,1,Firefox 32,3,2016-12-20
session,1,2,Chrome 6,59,2016-11-11
session,1,3,Internet Explorer 10,28,2017-04-29
session,1,4,Chrome 13,116,2016-12-28
```

## USAGE

`bin/report ./data/data.txt result.json`

report stores in `reports` dir.

## PERFORMANCE OPTIMIZATION

* Read file line by line: `File.new(file_path).each`
* Use bang methods, for example `sort!` instead `sort`
* Free objects in collection while iterating over them: `user = collector.users.shift[1]`
* Avoid to use `Date.parse`
* Use cache in instance methods
