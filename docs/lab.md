# 仮想環境関連
検体などの解析用に専用のVMを作っておくのは必要かも．
使いやすかったりツールの豊富なディストリビューションをまとめておく

## Windows
商用OSなので仮想環境の用意がネック．まぁgoogle先生が色々な方法を知ってるみたい(?)

- [FLARE VM](https://github.com/fireeye/flare-vm) (FireEye Labs Advanced Reverse Engineering)  
FireEye社の配布しているWindows用の解析ツールをまとめたPSスクリプト．  
面倒な窓での環境構築を自動化しておりドチャクソ便利．パッケージ管理も`choco`．  
ただし，キャッシュやチェックサムでコケやすいので「動けばいい」人は`choco config set cacheLocation C:\tmp`と`choco feature disable -n checksumFiles`を設定すればいい．checksumを無視するので解析前にマルウェアが混入するリスクも高いしおすすめはできない．

## Linux
多くのディストリビューションがあり，ペンテスト系も充実している．

- [Kali Linux](https://www.kali.org/)  
ペンテスト特化型のディストリ．今まで使っていたけれど重たいので最近はあまり使っていない．もしもに備えてLiveUSBだけ用意している．

- [Black Arch](https://blackarch.org/)  
ペンテスト系ツールをまとめたArchLinuxの派生ディストリ．ArchLinuxへリポジトリの追加も可能．pacmanでメンテナンスできるので楽．ツールをぽちぽちするので，それなりに環境構築のコストは高い．カテゴリ分類が優秀でNFCやドローン，車関連のツールもメンテナンス対象になっている．  
ArchLinuxへ入れる際は，アプリケーションメニューを整理したほうが無難．xfce4向けには[blackmate](https://github.com/Anyon3/blackmate)がある．

- [REMnux](https://remnux.org/)  
マルウェア解析に特化したディストリ．ちょっと環境が古いのともっさり感は否めない．SANSのトレーニング資料がかなり参考になる．疑似インターネット環境を作るための`inetsim`や`honeyd`もあり，exeやpsファイルを除けば動的解析はこれでいいんじゃないかな．

- [Tsurugi Linux](https://tsurugi-linux.org/index.php)  
最近使っているのはこれ．AVTokyo2018でお披露目となった．`Logon Tracer`や`OSINT Switcher`をはじめ，他には初期からあまり入っていないツール群が多くDFIR向け．マルウェア解析系のツールも揃っている．  
仮想環境へ入れる場合は，Ubuntu MATEベースということもあり，grub関連でコケやすい．とりあえずは`レガシーBIOS`で起動するのが無難かも．

## MacOS
知らん．ホストOSとしてVM環境を用意する側じゃない？業務でも無い限り，解析ツール導入してエイヤはあまりしたくない．