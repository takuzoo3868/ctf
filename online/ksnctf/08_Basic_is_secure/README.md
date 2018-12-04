# ksnctf: Basic is secure? 

**Category:** Network  
**Points:** 50pt  
**Description:**  

> http://ksnctf.sweetduet.info/q/8/q8.pcap

**Hint:**

>

## 解き方
`pcap`が配布されるので，脳死でwiresharkを開きhttpでフィルタをかけてみる．(タイトルからしてBasic認証だろうなと思ったので)

![img01](../assets/img/Screenshot_2018-12-04_23-44-07.png)

`No.9`で認証の要求があることから，`No.13`で認証情報を送信し，コンテンツを要求しているだろうなと目を付ける．httpの`Authorization`に目的のCredentialsがありflagを入手できる．basicは`base64`のエンコードなので，デコードで中身が丸見えだねといった意図があるのかな．デコードは`echo "hogefugapiyo" | base64 -d`で簡単に出来てしまうし...

![img02](../assets/img/Screenshot_2018-12-05_00-02-58.png)

一連のやり取りの最後に`favicon.ico`ねぇーよ！と言われているのがツボでした．
