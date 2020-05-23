# Keynote: Katie Hockman Go module proxy LoQ

## 概要
特になし

## 発表者
Katie Hockman氏は2018年にニューヨーク市のGoチームにソフトウェアエンジニアとして加わり、Go module proxyを構築するチームを率いている。彼女はGoチームに加わる前にGoogleで3年間働き、Java、Python、Javascript、そして小さなTypescriptでコードを書いた。最近では、Googleを障害者にとって最高の職場にすることを目標に、アクセシビリティチームのフロントエンド作業を行っている。

## 内容
google slideって文字起こしの機能あるんだ．
質問アプリいいね https://app2.sli.do

golang package v.major.minor.patch
そんなpackageにおけるmodule管理をどうにかしたい(?)

- https://github.com/katiehockman/puppies

module で使いたい機能は一部だけれど現状はすべてをキャッシュしなければならない．それって怠惰じゃない？
必要なファイルだけほしい　そんなときに go module proxyを使ってくれ
バージョン情報とか取得できる キャッシュサーバを利用するのはGithub依存を脱却するため

ドキュメント
- https://golang.org/cmd/go/#hdr-Module_proxy_protocol

> goコマンドは、「行く 」が常にそうであるように、デフォルトでバージョン管理システムからモジュールを直接ダウンロードします。GOPROXY環境変数を使用すると、ダウンロードソースをさらに細かく制御できます。GOPROXYが設定されていない場合、が空の文字列の場合、またはが文字列「直接」の場合、ダウンロードではバージョン管理システムへのデフォルトの直接接続が使用されます。GOPROXYを「オフ」に設定すると、どのソースからもモジュールをダウンロードできなくなります。それ以外の場合、GOPROXYはモジュールプロキシのURLであることが期待され、その場合、goコマンドはそのプロキシからすべてのモジュールを取得する。モジュールのソースに関係なく、ダウンロードされたモジュールはgoの既存のエントリと一致する必要があります。sum(検証の議論については「ヘルプモジュールへ移動 」を参照)。

経緯　アナウンス
- https://groups.google.com/forum/m/#!topic/golang-dev/go6_lZqew6g

昔はhttpsで直接checksumしていた えぇ
これからのchecksum database　木構造(Merle Tree ?)でバージョン管理を行う　ツリーにタイルを適用する考え方は知らなかった
参考：http://www.certificate-transparency.org/

話の内容的にはmoduleのバージョン指定を保証するための技術をどうするといった感じかな...
> Checksum 関連のアルゴリズムの類似した感じのものは BlockChainのMerle Tree かな?
https://coincentral.com/merkle-tree-hashing-blockchain/

$GOSUMDB
- https://godoc.org/github.com/golang/go/src/cmd/go#hdr-Module_authentication_failures

proxyは環境変数として指定する(?) 試したいなら1.13-devを使え
`GOPROXY=https://proxy.golang.org`

プライベートの場合は`GONOPROXY`をどうぞ．

### slide

https://github.com/katiehockman/puppies/blob/master/presentation_slides.pdf


# Hacking Go Compiler Internals 2

## 概要
Since the previous talk at Go Con 2014 Autumn, lots of things in the internals have changed. In this talk, I will try to give an overview of Go compiler internals and update the information as much as possible, along with my new hacks.

## 発表者
Speaker: Moriyoshi Koizumi
Twitter: moriyoshit

## 内容

- https://github.com/golang/go/tree/master/src/cmd/compile/internal

Goコンパイラの内部構造について
1. lexer
意味のある単位に分割　ソースコードをトークンに分割

1. parser
抽象構文木ASTへ変換　意味論

1. Annotated AST constraction
型推論のために型情報と分離をさせる（アノテーション）ため

1. Typechecking
(一番時間がかかる)

2. Variable capturing
変数束縛　効率的な処理のため
> クロージャへの値渡し、参照渡しも後のコードを見て判断

1. Inlining
コスト計算でインライン化の判断
> Clang とかだとインライン化されるかどうかは score をつけて threshold で決める

1. Escape Analysis
変数のアドレスが漏洩しないか，ポインタなどを見てチェック
内部で変数の所有権を移譲
> スタックに積まれるべき一時変数が他の部分で使用される可能性があった場合はヒープ領域に退避させるようコードを変更する

1. Closure Rewriting
最適化するために、クロージャの関数外出しして通常の関数呼び出しにする

1. Walk
?

1. SSA Generation
golangを機械語に近いSSAに変換　Goのコンパイラに最適化が無いのでSSAを導入した？
https://qiita.com/tooru/items/a55bcdac0500d9a93f39

1. 機械語生成

## スライド

https://speakerdeck.com/moriyoshi/hacking-go-compiler-internals-2nd-season


# Security Scan for golang Using Open Source
13:45 room C

## 概要
このトピックでは、オープンソースの静的分析セキュリティー・テストを使ってセキュリティー問題のgolangコードを見つける方法を説明します。開発者が侵入テストの段階を待たずに、開発段階からセキュリティ問題を発見して修正できるようにする

## 発表者
Speaker: Harley Davidson Karel
Twitter: harleydavidkar1

## 内容

設計と開発で突き詰めないと脆弱性を生むと言っている
アプリケーションの静的解析にGolangのツールを使おうという話 ペネトレ

そっかGoでもSQLに触ることあるのね

- OSS SAST ツール
脆弱性調査を楽にするためにツールを導入した gosec
https://github.com/securego/gosec
色々な出力フォーマットがある．
linterも有効にできる
https://github.com/golangci/golangci-lint#disabled-by-default-linters--e--enable

デモに使っていたGo製のBWA
https://github.com/0c34/govwa
`$ gosec govwa/...`
`$ gosec -fmt=html -output=hoge.`
html形式で吐くとブラウザで見やすい形に
どこのソースコードに脆弱性があるかgosecは教えてくれる

CircleCIに組み込むと開発が便利になるかも？
> ペネトレーションテストはCI/CDでgosecを実行で実現してsecurity issuieが出てきた場合はgithubとかでisuueをJIRAとかでチケット化する

# 煩雑な運用をGoを使って楽にする

## 概要
プロジェクトを運用していると日々様々なタスクが発生します 例えばExcelでやりとりされるデータを適切に処理する必要があったり、Google Driveに保存してあるファイルを処理しつつバージョン管理する必要があったり、特定のファイルを大量に生成する必要があったり などです そんなGoで開発/運用されているのプロジェクトで起きた課題をどのように解決し、またその過程で嵌った点などを紹介できればと思います

## 発表者
Speaker: Ryosuke Yabuki
Twitter: Konboi

## 内容

- EcelをGoから扱う　
フォーマットも指定できる
https://github.com/360EntSecGroup-Skylar/excelize

- GoogleDriveをGoからあつかう
基本はSDKで対応できる
ファイルリストはFieldを指定する必要 指定しないとid,name,kind,mineTypeのみ　必要なパラメータを指定する事を確認
UpdateはListAPI経由でFileObjectを取得
再帰的なファイル取得は厳しい `Google Drive API v3 再帰`で検索
大量ファイルの生成はgoroutineでは険しいのでGoogleCouldFunctionを使おう (まるでDoSまがい)

https://github.com/Konboi/go-google-drive-example

## スライド

https://speakerdeck.com/konboi/go-conference-2019-spring

# Writing Go Analyses with go/analysis (from Go Team)

## 概要
Analysis APIは、バグの特定に役立つ分析(ゴベットして糸くずになるような)を記述し、コードの改善をユーザーに示すために使用されます。ここでは、コード品質の向上に役立つように、分析の使用方法と作成方法、およびその結果の表示方法について説明します。

## 発表者
Speaker: Michael Matloob

## 内容

go/analysisの開発者
ASTっぽいのかな？

go/analysisでAnalyzerを作るなら https://github.com/gostaticanalysis/skeleton が作りやすいよ(twitter情報)
> inpsectorでASTを簡単に探索できます。フィルターにセットした型のASTのノードだけが渡されま

- https://godoc.org/golang.org/x/tools/go/types/typeutil

- cmp.Equalsに渡された引数が同じ型かどうかをチェックするAnalyzer
- まずはASTから関数呼び出し（CallExpr）を探して、渡されている引数を探し、その型を型情報から取得して同じ型か調べている
- cmp.Equalsだけではなく、同じ型を取らないといけない場合にアノテーションを仕掛けたらチェックするようにする
- アノテーションはannotationパッケージのSameType関数を用いる

- Using fact
https://godoc.org/golang.org/x/tools/go/analysis#Fact

ちょっと参考になりそう
https://budougumi0617.github.io/2019/02/01/how-to-use-analisys-package/

`gopls`

## 発表資料(github)

https://github.com/matloob/analysistalk

# Dive into Buildkit LLB with Go

## 概要
Dockerに正式統合されたBuildKitをGoで扱う方法について発表します。

BuildKit は Goで実装されている為、Goのソースコードを読むことでGoを使ったDockerfile解析ツールや、独自のBuildKit LLB frontendを作成できます。

今回の発表ではGoでどのようにBuildkitが記述されているかをコードを追いながら、Goを使ったDoコンテナイメージフロントエンドの解析ツールの作り方や、独自のコンテナイメージフロントエンドの作り方にも触れて行く為、Goでコンテナ技術を理解する大きな1歩になるでしょう。

## 発表者
Speaker: po3rin
Twitter: po3rin

## 内容

TBA

# Building Modules Discovery (from Go Team)

## 概要
どこかの時点で、私たちはGoコードにサードパーティのGoパッケージを使いたいと思うようになります。このトークでは、Goのパッケージとモジュールを発見、評価、保守するための戦略について説明します。また、Goチームがこのプロセスを改善するために開発している新しいツールも共有している。

## 発表者
Speaker: Julie Qiu

## 内容

DockerfileをLLBへ変換してwoker(buildkitd)へ渡してビルドしている

`github.com/moby/buildkit` の話
- dockerを並列にビルドできる(?)
- BuildKit は docker build に統合済なので環境変数を設定するだけで使える。
- その裏は buildkitd と buildctl で構成されている。
- BuildKit は 95% ほどが Go なので、 Go 開発者は BuildKit ベースのツールを開発できる

> BuildKit はマルチステージビルドを並列化と思われがちだけど、  LLB 上は RUN とかの1ステップごとに共通化できる。

llb = low level builder
Dockerfile as a DAG(directed acyclic graph)

作った
https://github.com/po3rin/llb2dot
llb2dot package lets you to convert BuildKit LLB to dot language to analize. You also can directly load Dockerfile.

buildkitのパーサーを使ってDockerfileのlinterを作ることができる
> Dockerfileのlinterを作ったりできる、たとえば、「Dockerfile内で環境変数を与えていないか」みたいなlinterを作ることも可能。

はぁオレオレツールを作れるんですね `gockerfile` 車輪の再開発感が否めぬ　既存のツールに比べて何が良いのだろう...

## 資料

https://qiita.com/po3rin

# We want AWESOME CLI tool & development

## 概要
golang と言えば CLI ツール、CLI ツールと言えば golang、といった純粋想起が醸成されつつあります。初学者から達人まで、あらゆる Gopher が CLI ツールを開発し、CLI ツールの開発は難しくないと思われがちです。しかし、「優れた」設計・テスト・UI・ビルド・リリース・アップデート・CI・ドキュメンテーションなど、「より」CLI ツールを洗練するために考慮すべき点はあります。一方でその知見はあまり集合知として語られず、「達人」であっても疎かになっている点はあります。そこで今回は CLI ツール開発の包括的知見を紹介したいと思います。

## 発表者
Speaker: micnncim
Twitter: micnncim

## 内容

なぜGolangでCLI？
- クロスコンパイルが楽
- シングルバイナリで配布

CLIのベスト・プラクティス
UX/DX設計　テストしやすさ　クロスプラットフォーム対応　インストール方法　しっかりとしたドキュメント(GUIと違い直感的にわからないから)

Design I/O 
fmt.Println()をそのまま使うのはテストに優しくない io.Writerを使おう githun/hubを参考にするとI/Oの設計はわかりやすい
> CLIのテストは標準のos/execやlogパッケージのテスト手法をまねるとよい 

Handling Exit code
errorを履いているのにExit code 0は避けたい
typeを使ってハンドリングする e.g. github/hub

Test with golden files
提唱はHashicorpのミッチェルさん
テストで期待する(巨大な)出力を .goldenに記述　テストの比較に使う

Pkg for Cross Platform
e.g. mitchellh/go-homedir

ビルドとリリース
go getはビルドがこける... github releaseもあるけれど...
GoReleaser YAMLとコマンドでクロスコンパイルに対応
https://github.com/goreleaser/goreleaser
CI/CDもこのツールで便利になる

## スライド

https://speakerdeck.com/micnncim/we-want-awesome-cli-tool-and-development

# CPU, Memory and Go

## 概要
基本的なCPUやメモリを簡単に触れ、Goの最適化、コンパイラの最適化、Goで実装したときのCPUやメモリの振る舞いを紹介します。 またこれら最適化の様子やパフォーマンスを実際にGoの標準ツールを使いながら確認していきます。

## 発表者
Speaker: そな太
Twitter: sonatard

## 内容

あらためてGoってどんな言語かCPUやmemoryから見る

- アムダールの法則(CPU高速化)

最適化 inline展開 利用していないコードを削除
Goの標準ライブラリでは const debug で変数を定義してデバッグ有無をキメている　これはコンパイルの観点からベスト

クラスと構造体の違いはメモリ配置にある
構造体はプログラマがメモリ配置を把握しやすい，バイナリデータとしてそのまま扱える(そのままメモリに格納されるから)
つまり低レイヤで扱いやすい

スタックとヒープの選択
ヒープのメモリ確保は遅い処理　サイズが分かっているときは一度に確保する
確保したアドレスはメモリ空間が連続する　つまりキャッシュヒット率が上がる　動的メモリ確保のコストを下げている
スタックはブロックを抜けると開放される　スライスでなくてもメモリアドレス空間が連続に　空間敵局所性がup

メモリアライアント
構造体のメモリ確保　2byteの隙間-->パディング
CPUがメモリにアクセスするバスサイズに揃える事ができる　なぜ？
アライメント境界を跨がないようにするため　でもアライメントより小さい型の理容は必要ない　メモリ節約の観点で言えばケースバイケース(プログラム的に意味があるときだけ...)

> プロトコル開発をするときはアライメントを意識しないとプログラマから恨みを買うらしい

Escape Analysis
アドレスを渡していなければスタックされる

安全性
メモリアドレスの操作　Goではメモリに直接書き込むことはない バッファオーバーフロー対策
メモリアライメントの境界をまたぐ　Cの場合は跨いだ実装ができてしまう

生産性
オブジェクト指向　構造体に対してメソッドを生やすこともできる

> "Rules of Optimization:
> Rule 1: Don't do it.
> Rule 2 (for experts only): Don't do it yet. ” - Michael A. Jackson

## スライド

https://speakerdeck.com/sonatard/cpu-memory-and-go

# 気になったけれど聞かなかったやつ

# Better asset bundling tool than the best

## 概要
I am creating new asset bundling tool. It will have some new features that the existing tools don’t have

## 発表者
Speaker: Yoshiki Shibukawa
Twitter: shibu_jp

## スライド

https://docs.google.com/presentation/d/1_FfMqmcrfPGNTGeo6okTwC08742H19XVpnm9l98KvSc/edit


# Goによる外部プロセス起動ベストプラクティス及びtimeoutパッケージ徹底解決

## 概要
Goで外部プロセスを起動する方法をシステムプログラミングにまで踏み込んで解説します。また、外部コマンドのタイムアウトを正しくハンドリングするための、github.com/Songmu/timeoutパッケージの解説もおこないます。これはGNU timeoutのGo portingですが、GNU版との差異についても解説します。

## 発表者
Speaker: Masayuki Matsuki
Twitter: songmu

## スライト

http://songmu.github.io/slides/gocon2019-spring/#0

# Design considerations for container-based Go applications

## 概要
Go言語でのアプリケーション開発で、特にコンテナを前提とする場合の設計考慮点について話します。 例えば、Go言語でAPIを開発する場合、コンテナとして動かすことを前提とするケースが多いと感じます。コンテナベースで動かすことを前提とした場合、コンテナイメージ作成・アプリケーション監視において、考慮すべき点が出てくるでしょう。このトークでは、Go言語での実装にまで踏み込んだ上で、コンテナベースアプリケーションにおける設計の考慮点について話します。

## 発表者
Speaker: Kazuki Higashiguchi
Twitter: hgsgtk

## スライド

https://speakerdeck.com/hgsgtk/design-considerations-for-container-based-go-application

# Expand observability in Go

## 概要
Go standard toolkit provides benchmark, tracer and profiler out of the box and its ecosystem provides those extensions that fit large-scale systems. In this talk, I’ll introduce how you can start implementing performant applications with standard tools, and how you can expand it to larger scale app.

## 発表者
Speaker: Yoshi Yamaguchi
Twitter: ymotongpoo

## スライド

observability: システムの状態を指す(観測が可能な状態)
Monitor : 監視
ユニットテスト:出力値を期待値と比較
パフォーマンスチューニング:メトリクス出力値を期待値と比較

https://bit.ly/20190518-gocon-spring

## Golang JP Google+ Community Survey Results
- https://talks.godoc.org/github.com/qt-luigi/talks/2019/survey-results.slide

## エラー設計について/Designing Errors
- https://docs.google.com/presentation/d/1JIdZ4IVW2D3kEFUtWSvHNes3r3ykojGuUAQAnhmEVs0/edit

# GolangでDockerベースのCIを作る

## 概要
Continuous Integration (CI) は開発者にとってなくてはならないものですが、 CI定義などの学習/メンテナンスのコストや、ローカル開発環境との差分に悩まされることもあります。 そこで、Dockerfile のみで定義を行うCIサーバーを開発しています。 GolangにはCIサーバーの開発に必要な機能を実現するための仕組みが数多く備わっており、本発表ではそれらについて紹介したいと思います。

## 発表者
Speaker: Shunsuke Maeda
Twitter: duck8823

## スライド

- https://speakerdeck.com/duck8823/golangdedockerbesufalseciwozuo-ru

# database/sql入門

## スライド
https://speakerdeck.com/budougumi0617/introduction-database-sql

# 他の方のメモ
https://scrapbox.io/aya-eiya-reports/Go_Conference_2019_Spring

https://khigashigashi.hatenablog.com/entry/2019/05/18/162918

# スポンサー

https://speakerdeck.com/unblee/cache-design-in-kubernetes-api-client

 # LT
 いい話だった

 https://docs.google.com/presentation/d/1RWbGPNlMUlSW98pUVn5GNaWgoaON481mnGJft47pEKU