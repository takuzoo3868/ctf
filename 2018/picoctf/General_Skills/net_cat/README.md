<!-- This markdown file is writeup template. -->

# PicoCTF_2018:  Net Cat

**Category:** General Skills  
**Points:** 75pt  
**Description:**

> Using netcat (nc) will be a necessity throughout your adventure. Can youconnect to `2018shell2.picoctf.com` at port `22847` to get the flag?

**Hint:**

> ['nc <a href="https://linux.die.net/man/1/nc">tutorial</a>']

## Write-up
`netcat` コマンドを用いて接続するだけ

```bash
$ nc 2018shell2.picoctf.com 22847
That wasn't so hard was it?
picoCTF{NEtcat_iS_a_NEcESSiTy_69222dcc}
```

## Flag

`picoCTF{NEtcat_iS_a_NEcESSiTy_69222dcc}`