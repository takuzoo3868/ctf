<!-- This markdown file is writeup template. -->

# PicoCTF_2018:  Heeeeeeere's Johnny!

**Category:** Cryptography  
**Points:** 100pt  
**Description:**

> Okay, so we found some important looking files on a linux computer. Maybe theycan be used to get a password to the process. Connect with `nc2018shell2.picoctf.com 35225`. Files can be found here:[passwd](//2018shell2.picoctf.com/static/a488bb3c175bc843e0fbce95fff920d9/passwd)[shadow](//2018shell2.picoctf.com/static/a488bb3c175bc843e0fbce95fff920d9/shadow).

**Hint:**

> ["If at first you don't succeed, try, try again. And again. And again.", 'If you\'re not careful these kind of problems can really "rockyou".']

## Write-up
`passwd`と`shadow`ファイルが渡されるので，定番のJohn the Ripper君に頑張ってパスワードを解読していただく．

```bash
$ john shadow     
Warning: detected hash type "sha512crypt", but the string is also recognized as "sha512crypt-opencl"
Use the "--format=sha512crypt-opencl" option to force loading these as that type instead
Warning: detected hash type "sha512crypt", but the string is also recognized as "crypt"
Use the "--format=crypt" option to force loading these as that type instead
Loaded 1 password hash (sha512crypt, crypt(3) $6$ [SHA512 64/64 OpenSSL])
Will run 4 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
hellokitty       (root)
1g 0:00:00:05 DONE 2/3 (2018-09-29 01:33) 0.1915g/s 962.2p/s 962.2c/s 962.2C/s ilovegod..celtic
Use the "--show" option to display all of the cracked passwords reliably
Session completed
takuya@Sco-Antares:~/CTF/2018/picoctf/HEEEEEEERES_Johnny$ nc 2018shell2.picoctf.com 35225
Username: root
Password: hellokitty
picoCTF{J0hn_1$_R1pp3d_99c35524}
```

## Flag

`picoCTF{J0hn_1$_R1pp3d_99c35524}`