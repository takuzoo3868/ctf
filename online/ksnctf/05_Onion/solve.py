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
