# How to become a phisherman (Phishermanになる方法) by ninoseki (Manabu Niseki)

## 概要
フィッシングは昔からある技術ですが、現在も利用されています。どのようにフィッシングが行われているかを理解するためにはフィッシング詐欺者を見つける必要があります。このトークではフィッシングキットを見つけ出す方法とそのツールを紹介します。これはOSINTをベースにしており、誰でも無料で試すことができます！

## 発表者
ninosekiはCSIRTで働いている研究者で、情報セキュリティ関連を中心に取り組んでいるOSSコントリビュータです。

## 内容
フィッシングキット：そういうサイトをデプロイするツール
- C2をテイクダウンしてデプロイされているサイトを調査
- 開発者の情報が含まれていることも

`Index of` みたいにオープンディレクトリになっているサイトからツールを収集できる

自動化したツール https://github.com/ninoseki/miteru 
- urlscan.ioに渡している？ちょっと聞いてなかった
- Certificate Transparency 証明書の不正な発行などを監視
- 更には発行したドメインも見れる！つまりフレッシュなURLが漁れる (why) Certificate Transparency log serverに記録されるから
- x0rzさんのアルゴリズム使って判断しとる
- 49%はSSLで発行してる

https://developers.facebook.com/tools/ct/search/

https://certstream.calidog.io/
Certificate Transparency log serverを15秒間隔でクロールする

一日何件くらい？　4時間で2,30件
メール以外に何で開発者を判断？　クレジットやSNSアカウント

### slide

https://speakerdeck.com/ninoseki/how-to-become-a-phisherman

# Another one bites the apple! (Appleに噛み付くもう一つの物！) by ramses (JunHo Jang)

## 概要
OSX/iOSのカーネルには、IOKitやシステムコール、MIG(Match Interface Generator)ハンドラといったユーザスペースからのアタックサーフェスがあります。特に、MIGはLINUXやUNIXとは異なるXNUカーネル特有の機能です。

このトークでは、XNUカーネルのMIGハンドラから脆弱性を見つけることに関連したいくつかの方法を紹介します。

XNUカーネルのMIGハンドラの解析
XNUカーネルのコンパイルによる簡単なファジングフレームワークの作成
カーネルのヒープバッファオーバーフローの脆弱性(0-day)の解析
最後に、この脆弱性を悪用する時の課題について話す予定です。

## 発表者
 私のLINEでの業務は、暗号通貨が安全に交換できるように保つことです。そのために、ソースコードの監査やインフラ構成のチェック、セキュリティポリシーのアセスメントを行っています。 
また、私はPLUSというチームのメンバーとしてCTFに参加していました。 10年前、私達のチームはDefcon CTFで3位に入りました。バグハンターとしては、WebブラウザやAppleの製品のバグを見つけることにとても興味があります。

## 内容
アップル製品 macOS iOS 類似性が高い deamonが同じだったり，kernelが共通

XNUにはBSDとMach(カーネギーメロン大学が開発)を混合したカーネル．

MIG = Terminalにman migを入れるとhelp出てくる
これをFuzzingしましょうねという話 --> MiG Fuzzer

そうかJailBreakの可能性もあるのか
ファジングの結果で見つけた脆弱性は2つ　カーネルヒープのバッファオーバーフローを検証
Kernel Heap Feng-Shuiというテクニック

(スライドをスニペットと変数とメモリマップで分割するのいいな...)

Safari 0day
変数に格納したデータのleakが発生している 'var s = "aa";'


# Betrayal of Reputation: Trusting the Untrustable Hardware and Software with Reputation (評判の裏切り: 信頼できないハードウェアやソフトウェアを評判によって信頼すること) by kkamagui (Seunghun Han)

## 概要
評判は信頼に基づいており、人々は通常、IntelやHP, Dell, Lenovo, GIGABYTE, ASUSといったグローバル企業の製品を、企業の評判を元に信用しています。これらの企業の製品は、企業によって作られるか検査されるかした各種のハードウェアとソフトウェアで構成されています。グローバル企業は高品質の製品を作ったり維持したりすることで、利益と評判を得る努力をしてきました。そのため、評判に基づいた信頼は正しく機能します。そのような努力にもかかわらず、ハードウェアとソフトウェアはどんどん複雑になっており、製品に関連した仕様と実装の正しさや完全性を確認することは難しくなっています。

このトークでは、ハードウェアやソフトウェア、特に BIOS/UEFIファームウェアやIntel Trusted Execution Technology(TXT)、Trusted Platform Module(TPM)が信頼を裏切っていることを紹介します。評判のよい企業がそれらの仕様を策定し実装を行いました。TPMとUEFI/BIOSファームウェアやTXTは広く利用されており、信頼の根幹を担っています。

私はsleepプロセスに関連したCVE-2017-16837とCVE-2018-6622の2つの脆弱性を発見しました。これまでの研究とは異なり、この脆弱性は物理的なアクセスなしにTPMを壊すことができます。この脆弱性を緩和するために、脆弱性を確認する対策ツール「Napper」を紹介します。sleepプロセスはこの脆弱性における重要な部分なので、Napperはシステムに仮眠を取らせてチェックをします。

## 発表者
 Seunghun Hanは現在は韓国のNational Security Research Institute所属のハイパーバイザとOSのセキュリティ研究者で、前職はサムスン電子のファームウェエンジニアでした。ハイパーバイザの専門家で、Shadow-boxというハイパーバイザの作者です。また、LinuxカーネルとBIOS/UEFIファームウェアに関するいくつかのCVEを所有しており、様々なシステムやセキュリティソフトウェアにパッチを提供しています。

USENIX Security、Black Hat Asia、HITBSecConf、beVX、KIMCHICONの講演者及び執筆者です。

また、以下の書籍の著者です: "64-bit multi-core OS principles and structure, volume 1 (ISBN-13: 978-8979148367) and volume 2 (ISBN- 13: 978-8979148374)"。

## 内容
評判がいいが信頼できないものを紹介していく
Reputable ≠ Trusatable

https://sourceforge.net/projects/tboot/
ブートプロセスにあるDLMEは確かに完璧だけれど sleep processは？

SRTMとDRTMの仕組みについて解説している

参考: http://www.cs.wayne.edu/fengwei/18fa-csc6991/slides/tpm-oskars.pdf

参考: https://www.usenix.org/sites/default/files/conference/protected-files/security18_slides_han.pdf

結論としてはBIOS/UEFIのアップデート大事やぞってこと
我々はハードウェアのセキュリティを盲信している

TPMの不具合はよくあることなの？ ハードウェアの仕様による，メーカーの設計次第