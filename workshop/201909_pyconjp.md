# PythonとAutoML

自動化のレベルについて

1. 学習器お手製
1. ハイパパラメータ調整の最適化
2. 特徴量作成や選択の自動化
3. もう何もお手製コードを書かない

ベイズ最適化
不確実性を考慮してみる感覚に近い
関数全体の回帰：勾配ベースより局所解へ陥りづらい

悪いパラメータを早い段階で切ってしまう：早期停止

## optuna
Goptunaもある．Golangへ移植された
複数ワーカーでの最適化するときはSQLite3を避けよう
GPベースでモデル選択とハイパラ選択する場合は、Optunaだとすこし大変(@chezou)

ベイズ最適化は分散環境上では課題がある
コンコ改良できそうな分野

## scikit-optimize
GPベースのベイズ最適化として有力
skleran v0.22から試すといいよ！かなり高速化してる

## 特徴量生成
有名なライブラリでも現状多くのことはできない
・特徴量生成
・特徴量選択

memo: https://qiita.com/kazuki_hayakawa/items/162cc36fbbc9440c0645

featuretools DFSアルゴリズムに依る特徴量生成
tsfresh 時系列データに特化した特徴量生成・選択ライブラリ

## 特徴量選択
予測器の性能up,高速化,解釈性up
scikit-learnやBoruta
sklearnのRFEはちょっと時間がかかる

## アルゴリズム選択の自動化
この自動化ではハイパパラメータ最適化も一緒に扱う必要がある
auto-sklearn
SMAC3を用いたベイズ最適化で行っている
tpot
ベイズ最適化ではなくNAGA-II(遺伝的アルゴリズム)を用いている

# Dashによる日本経済

- データは可視化するとよく分かる
- 現在のプレゼンツールはデータを扱いにくい
- データは時間をかけて分析する価値がある

インタラクティブな可視化フレームワークDash
Flask、React、Plotlyの組み合わせでできている

dash：枠作り
dash_core_components：グラフ作成
dash_html_components：html箇所

## データ分析の問題点
データ分析に対する理解の隔たりとデータ分析結果の共有の難しさ
依頼者が欲しいデータではなかった！

Dashで詳細なデータを共有
- 情報量が増えるとわかることも増える
- もっと掘り下げたいところが分かる

※Tableauより低コスト

データ分析はやり方次第でどうとでもなる
データ分析はテクニックではなく依頼者と分析者の互いのいたわりである

# ML Algorithm to Detect Rare Clinical Events

> 人工ニューラルネットワークと機械学習における最近の進歩は,医療診断に革命を起こす可能性を持っている。アルゴリズムは、マンモグラムなどの画像を分類するために、または外科的切除のための容量分析に使用され得る。しかし,機械学習アルゴリズムには,臨床展開前に対処する必要がある限界がある。通常の分類ベースの機械学習アルゴリズムでは十分ではない。代わりに,訓練データを持たないクラスを含む異なるクラスの正確なクラスタリングを達成できる,データの高品質低次元表現を学習できる方法が必要である。これを実現するために,同じクラスから来た点が互いに近く,別々のクラスから来た点が遠く離れている潜在的表現空間を学習できる生成モデルを開発し,変分自動エンコーダ(VAE)ベースの生成モデルを訓練するための新しい損失関数を開発した。

データを収集しやすくなっても，クリティカルな誤判定の問題はつきまとう

TVAE: Triplet-Based Variational Autoencoder
https://arxiv.org/abs/1802.04403

Metric learning
データ間の関係を計量を用いて表現する特徴空間への変換を学習する手法
URL: https://qiita.com/Maizu/items/844f4dfcef9d04af03f2

Variational Autoencoder
潜在変数が確率分布に従う

URL: http://kvfrans.com/variational-autoencoders-explained/
参考: https://speakerdeck.com/katsunoriohnishi/variational-auto-encoderru-men

データの品質を担保する学習手法が必要みたいなことを言ってると思う
レアケースに対応できない点を改善したい
とりあえず論文見たほうが早そう

# pandasのStyling機能で強化するJupyter実験レポート
https://pandas.pydata.org/pandas-docs/stable/user_guide/style.html

Styling機能
データに色付けできる：条件付き書式，スタイル設定にCSS
DataFrameの一部のセルを強調して表示したいときに

CSS文字列を返すスタイル関数を定義
applymapまたはapplyを使って、スタイル関数を適用
※最後に適用したCSSが優先

各要素の値を個別に:applymap()
単体の要素だけではなく他の要素も含めて判断：apply()

正式ではないので，手元で使う程度に

# I will never restart! Automatic hot reloading in CPython

> Pythonには、利用されるのを待っている強力な動的機能がたくさんあります。REPLベースの開発については多くの人が知っているかもしれませんが、適切な種類のツールを使用すれば、Pythonはライブ・コーディング・ベースの開発サイクルを提供することができます。

> Pythonの自動ホット・リロードをサポートするライブラリー、mighty_patcherを取り上げます。これにより、プログラム全体を再起動しなければならない従来の「自動再ロード」トリックを回避できます。

> ここでは、これが何をするのか、どのように使用できるのか(迅速なテスト、ライブコーディング、インタラクティブアート)、そしてどのように実装されるのかについて、基本的なことを説明します。このツールがどのように動作するかを詳しく説明することで、内部の動作を理解した上で、Pythonで何が可能かを考え直すのに役立つはずです。

Python - Cna quickly prototype web app.

importlib.reload
https://docs.python.org/3.6/library/importlib.html#importlib.reload
サーバの処理は再起動しないといけない

ある class のinstance method の動作は importlib.reload で書き換えることはできず
再度instanciateしなければならない，面倒ね！！！
なぜなら，moduleの再読み込みをして，それ以降の参照コードに影響は与えるが，
それ以前に作成したオブジェクトには影響を与えないから．

classをリロードしたいよ〜
classの__dict__を再設定してinstanceの__dict__はそのままに
→not writable
それならデータはメモリに格納してClangでメモリ参照しよう

> ファイル更新した場合の書き換えを自動化→mighty_patcher
> 対象ファイルをAutoReloaderに登録するだけで編集したらhot reloadがかかる

Github
https://github.com/rtpg/mighty_patcher

参考：
https://docs.python.org/ja/3/howto/descriptor.html

# When AI meets 3000-year-old Chinese Palmistry
占いアプリをAIベースで構築した話っぽい

> 私たちが知っているように、多くの人は占いに夢中で、パームリーディングは誰もが自分の運勢を予測し始める最も簡単な方法の一つです。しかし、多くの人はまだ手のひらの線の識別に問題を抱えています。そこで、「手相読み」、「ディープラーニング」、「チャットボット。」を組み合わせて考えました。最初の2時間はハッカソンで過ごし、人間関係、キャリア、健康分析、予測などの基本的な手相を学びました。次に,実際のヒトの手掌の2000以上の写真にラベルを付け,それらの関係,キャリア,および健康についてそれぞれ6000以上のスコアを与えた。

> ディープラーニングTensorflowバックエンドを使ったKerasのCNNモデルにVGG-16(16層ネットワーク)を使っています。GPUを用いて加速し,10エポックとエポック当たり1000ステップの訓練を行った。モデルのMSEは1.3066で、評価MSEは1.1721です。全体的に、結果は新しいパームを予測するのに十分な堅牢性を備えています。

> Chatbotは、AppやWebと比べてモバイルユーザーにとってアクセスしやすく、ソーシャルメディアでの普及も容易だ。そこでわれわれはChatfuelを使ってFacebook Messenger上にAIチャットボットを作った。下にHandbotのユーザーフローを示す。私たちが設計したスムーズなUXは、80%のユーザー維持率を達成するのに役立ちます。

Train image -> Labeled Data -> VGG19 -> Test image -> Trained model -> Prediction

手相のラベリングについては，
それぞれの線について画像ごとにスコアリング[1,5]

テスト画像は256*256

AWS上のTPUマシン？を使ってPredictは5,6h程度
FB messengerにFlaskベースのチャットボットを作った．
画像のリサイズを行って学習モデルに突っ込む

当然画像処理の問題など色々ある　エッジ処理，解像度等など
これから集成していきますとのこと

多分料金はそんな使っていないように思える