<!-- This markdown file is writeup template. -->

# PicoCTF_2018:  Recovering From The Snap

**Category:** Forensics  
**Points:** 150pt  
**Description:**

> There used to be a bunch of[animals](//2018shell2.picoctf.com/static/b8561b04f5c7107ecb2f15c9a8c79fb8/animals.dd)here, what did Dr. Xernon do to them?

**Hint:**

> ['Some files have been deleted from the disk image, but are they really gone?']

## Write-up
配布された`dd`ファイルを`foremost`で解析するとイメージの中に埋まっていたjpgを抽出できた．その中にflagも入っていた．

```bash
$ foremost -t all -i animals.dd
foremost: /usr/local/etc/foremost.conf: No such file or directory
Processing: animals.dd
|*|
$ ll
total 10248
drwxr-xr-x 4 takuya      128  9 29 13:17 ./
drwxr-xr-x 3 takuya       96  9 29 13:11 ../
-rw-r--r-- 1 takuya 10485760  9 28 16:26 animals.dd
drwxr-xr-- 4 takuya      128  9 29 13:17 output/
$ cd output/
$ ll
total 4
drwxr-xr--  4 takuya  128  9 29 13:17 ./
drwxr-xr-x  4 takuya  128  9 29 13:17 ../
-rw-r--r--  1 takuya 1031  9 29 13:17 audit.txt
drwxr-xr-- 10 takuya  320  9 29 13:17 jpg/
$ cd jpg/
$ ll
total 2940
drwxr-xr-- 10 takuya    320  9 29 13:17 ./
drwxr-xr--  4 takuya    128  9 29 13:17 ../
-rw-r--r--  1 takuya 632333  9 29 13:17 00000077.jpg
-rw-r--r--  1 takuya 493564  9 29 13:17 00001313.jpg
-rw-r--r--  1 takuya 389187  9 29 13:17 00002277.jpg
-rw-r--r--  1 takuya 254837  9 29 13:17 00003041.jpg
-rw-r--r--  1 takuya 321758  9 29 13:17 00003541.jpg
-rw-r--r--  1 takuya 469105  9 29 13:17 00004173.jpg
-rw-r--r--  1 takuya 393003  9 29 13:17 00005093.jpg
-rw-r--r--  1 takuya  40384  9 29 13:17 00005861.jpg
```

![img01](./output/jpg/00005861.jpg)

## Flag

`picoCTF{th3_5n4p_happ3n3d}`