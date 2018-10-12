#!/usr/bin/env python

p = [
    70,
    152,
    195,
    284,
    475,
    612,
    791,
    896,
    810,
    850,
    737,
    1332,
    1469,
    1120,
    1470,
    832,
    1785,
    2196,
    1520,
    1480,
    1449,
]
flag = ""

for i, val in enumerate(p):
    flag += chr(int(val / (i + 1)))

print(flag)
print("(」・ω・)」うー!(/・ω・)/にゃー!")
