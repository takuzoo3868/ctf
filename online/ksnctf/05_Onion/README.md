# ksnctf: Onion

**Category:** Misc  
**Points:** 70pt  
**Description:**  

> Vm0wd2QyUXlVWGxWV0d4V1YwZDRWMVl3WkRSV01WbDNXa1JTV0ZKdGVGWlZNakExVmpBeFYySkVU  
...  
SFVLWWpOa1VGVlkKUWtWWGJtOTNUMVZPYmxCVU1Fc0sK


**Hint:**

>

## 解き方
問題名からTorかブログの暗号化に使ってるAESかと思ったけど，単に英数字のみなのでbase64を解読するだけっぽい．やたら長い暗号文をスクリプトにかけてデコードする．最後に意味がありそうな文字列が出力された．

```python
#!/usr/bin/env python

import base64
import sys

file = open('base64enc.dat')
m = file.read()
file.close()

while True:
    try:
        p = base64.b64decode(m)
        m = p
        print(p.decode('utf-8'))
    except:
        sys.exit()
```

```
begin 666 <data>
51DQ!1U]&94QG4#-3:4%797I74$AU

end
```

よくわからないので`begin 666`でググったところ`uuencode`というbase64の前身らしい．`uuenc.dat`に暗号文を記録しておく．`uudecode`でflagを取得できた．

#### Flag
```
FLAG_FeLgP3SiAWezWPHu
```