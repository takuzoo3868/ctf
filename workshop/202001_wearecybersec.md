# 第ニ回サイバーセキュリティ系LT会 in 東京

## Webバグバウンティの情報収集について
- Pentester Land

バグバウンティコミュニティ
- hackerone
- bugcrowd
  - discordベース

'#bugbounty #bugbountytip'

見ているTwitterアカウント
https://github.com/nahamsec/Resources-for-Beginner-Bug-Bounty-Hunters/blob/master/assets/media.md


## iOSデバイスの脱獄検知について
@Sh1ma さん

iOS Appは脱獄検知して起動不可にする場合が多い

- 脱獄ストアcydia://が開けるかチェック
- Cydia.appや/bin/shの存在
- system()の返り値 1:jailbreak

検知回避としてLiberty liteの様なパッチエディタが存在する

crackproofを使おうね

## コンテナセキュリティについて[Security Research]

Slerではセキュrティや監視を非機能というらしい
最弱のコンテナ設定 = アンチパターンを作る

- 上手く行かない状況の再現

今後の標準はdockerからcontainerdになりそう

基準はNIST: sp 800-190
- DLするimage
- 保管するレジストリ
- コンテナと動かkすDocker
- Dockerを制御するするオーケストレーション
- 動かすOS

コンテナの外通信が制限されていない

コンテナに/bin/bashをコピーしてsetuidすると権限昇格できてしまう
`--no-new-privilage`しましょう

デフォルトはDockerだうんでコンテナも死んでしまう
`--live-restore`

CIS docker ベンチマーク

docker-bench-securityで最低スコアを目指す

## seccompについて
https://drive.google.com/file/d/1D-Wfzwvj1E8he8orvQGiAglqNtVDMepB/view

syscallの制御 = seccomp
- Linuxにおいてサンドボックスを実現するためにプロセスのシステムコールの発行を制限する機能

分散コンピューティングでCPUを共有した時，他人のコードを信頼できぬ
kernelのサンドボックス機能

https://github.com/david942j/seccomp-tools

回避して/etc/passwdを開きたいよね〜
- x32 ABIによるseccomp回避
- ptraceによるseccomp回避 CVE-2019-2054
- 32bitへの移行
  - secompのブラックリスト方式は危ない

ホワイト方式でもサイトチャネルは回避できない

libcのexitは安全な設計になっている

セキュリティ機構を信頼しすぎないこと

## おうちNW

momomopas氏

https://drive.google.com/file/d/12Hu6M1u5lC1t0jWfJRVmizxEbDmJ6qAV/view

NW監視のためのツール選定
OSSで結構できるんだなという印象

## fintechベンチャーのリスクベースアプローチについて
https://docs.google.com/presentation/d/1OOm6io22-0GxB4bjKKeDQdk7RDue6PYZg46oWEGbZvE/edit#slide=id.g35f391192_00

スタートアップから見たリスクベースアプローチ
- 人的リソースの少なさ
- 供給の少なさ
- ドキュメント追従はハード

経営陣からなんとかしてセキュリティにコストをかけていくために

最重要資産の策定
その資産に対してペネトレ依頼
出てきた課題を対策会議

1000万yenくらいはペネトレに割いている
PCIDSS取得費用も含む

コーポレートエンジニアは組織の課題をテクノロジドリブンで解決

## モザイクアプローチ
https://speakerdeck.com/smasato/know-the-mosaic-approach

OSINT

自分をOSINTすることでOPSECを高める(なるほど)
http://commentscreen.com/

## Neural Trojan
Liu et al. "Neural Trojan"


話の流れは高江洲さんと同じかも --> やっぱりネクストキャンプでやった内容だ
学習データの汚染とかそのへんかも　論文詳解は多め

転移学習でNeural Trojanを残したままにすることが可能という発表がある

Q. AIの判断結果に対する人間による説明可能性
A. あとあと適当な理屈をつけることはできる。AIは計算しているだけ。どこに重みがあるか。まぁそんなもんかというスタンスが妥当
@cam_i8

「トリガーが来た時に有害な動作をさせる」ために
中間層のウェイトを人為的に設定
画像等の特定箇所にアテンションを付与

## キャプティブ ポータルについて

free wifi接続時に出てくる登録のアレ
そのサイトは信頼できるのか？

認証後にリダイレクトするよう商用ルータで設定している
e-mailの情報が抜かれる

NTT BP系が多い
偽のキャプティブ ポータルを作成する --> 番組の検証としてやった

便利なツールで言えば バイナップルのwifi


## Golang data race

Gomium Browserのexploit

- AAR/AAWプリミティブ手法
https://gist.github.com/hama7230/fa53db62313c0b326fea49a0d0180ac4

- 直にRIP取る手法
https://github.com/shift-crops/CTFWriteups/blob/master/2019/Google%20CTF/Finals/Gomium%20Browser/race-interface.go

