# ksnctf: Easy Cipher

**Category:** Crypto/Trivia  
**Points:** 50pt  
**Description:**  

> EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.


## 解き方
暗号文を見る限り意味のあるスペースの様なので置換暗号に目星をつける．
文末はピリオドだし序盤だしシーザー暗号だろう．という事で以下のようなスクリプトを実行．

```python
#!/usr/bin/env python

import sys
import string

def caesar(text, key):
    plain = ''
    for c in list(text):
        if 'A' <= c <= 'Z':
            plain += (chr((ord(c) + key - ord('A')) % 26 + ord('A')))
        elif 'a' <= c <= 'z':
            plain += (chr((ord(c) + key - ord('a')) % 26 + ord('a')))
        else:
            plain += c

    return plain
    
def main():
    str = 'EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.'
    for i in range(25):
        print("[*]ROT_{}:\n{}\n".format(i, caesar(str, i)))

if __name__ == "__main__":
    main()
```

出力結果の`ROT13`が読み取れる文章となっていた．

> ROT XIII is a simple letter substitution cipher that replaces a letter with the letter XIII letters after it in the alphabet. ROT XIII is an example of the Caesar cipher, developed in ancient Rome. Flag is FLAGSwzgxBJSAMqwxxAU. Insert an underscore immediately after FLAG.

解読結果は`ROT13`の説明．`FLAG`の後ろにアンダースコアの注意書き．
