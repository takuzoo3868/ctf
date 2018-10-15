<!-- This markdown file is writeup template. -->

# PicoCTF_2018:  Strings

**Category:** General Skills  
**Points:** 100pt  
**Description:**

> Can you find the flag in this[file](//2018shell2.picoctf.com/static/aead5528718d7c26733c42fadab63b6a/strings)without actually running it? You can also find the file in/problems/strings_3_1dbaafa1f8f0556872cad33e16bc8dc7 on the shell server.

**Hint:**

> ['<a href="https://linux.die.net/man/1/strings">strings</a>']

## Write-up
ELFが配布される．問題の通り`string`するけれど，目gerpは疲れるので`grep`で絞る．

```bash
$ file strings 
strings: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=2314611c2d1896727b70a37ce2d41c80bbf0fffe, not stripped
$ strings strings | grep pico
picoCTF{sTrIngS_sAVeS_Time_2fbe2166}
```

## Flag

`picoCTF{sTrIngS_sAVeS_Time_2fbe2166}`