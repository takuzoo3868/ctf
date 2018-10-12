#!/usr/bin/env python

import sys
import string


def caesar(text, key):
    plain = ""
    for c in list(text):
        if "A" <= c <= "Z":
            plain += chr((ord(c) + key - ord("A")) % 26 + ord("A"))
        elif "a" <= c <= "z":
            plain += chr((ord(c) + key - ord("a")) % 26 + ord("a"))
        else:
            plain += c

    return plain


def main():
    str = "EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT."
    for i in range(25):
        print("[*]ROT_{}:\n{}\n".format(i, caesar(str, i)))


if __name__ == "__main__":
    main()
