<!-- This markdown file is writeup template. -->

# PicoCTF_2018:  Ext Super Magic

**Category:** Forensics  
**Points:** 250pt  
**Description:**

> We salvaged a ruined Ext SuperMagic II-class mech recently and pulled the[filesystem](//2018shell2.picoctf.com/static/b9ff30ec03a9007fb1b1cd6ae15fae84/ext-super-magic.img) out of the black box. It looks a bit corrupted, but maybethere's something interesting in there. You can also find it in /problems/ext-super-magic_1_c544657e659accef770d3f2bc8384a8c on the shell server.

**Hint:**

> ['Are there any <a href=https://en.wikipedia.org/wiki/Fsck>tools</a> for diagnosing corrupted filesystems?  What do they say if you run them on this one?', 'How does a linux machine know what <a href=https://www.garykessler.net/library/file_sigs.html>type</a> of file a <a href=https://linux.die.net/man/1/file>file</a> is?', 'You might find this <a href=http://www.nongnu.org/ext2-doc/ext2.html>doc</a> helpful.', 'Be careful with <a href=https://en.wikipedia.org/wiki/Endianness>endianness</a> when making edits.', "Once you've fixed the corruption, you can use /sbin/<a href=https://linux.die.net/man/8/debugfs>debugfs</a> to pull the flag file out."]

## Write-up