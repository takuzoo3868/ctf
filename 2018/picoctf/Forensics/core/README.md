<!-- This markdown file is writeup template. -->

# PicoCTF_2018:  Core

**Category:** Forensics  
**Points:** 350pt  
**Description:**

> This[program](//2018shell2.picoctf.com/static/98e0066d40ecdb580ae59a473bcaf721/print_flag)was about to print the flag when it died. Maybe the flag is still in this[core](//2018shell2.picoctf.com/static/98e0066d40ecdb580ae59a473bcaf721/core)file that it dumped? Also available at/problems/core_2_6f573d741fe8c5c6518e4a29f04a1e19 on the shell server.

**Hint:**

> ['What is a core file?', 'You may find this <a href=http://darkdust.net/files/GDB%20Cheat%20Sheet.pdf>reference</a> helpful.', 'Try to figure out where the flag was read into memory using the disassembly and <a href=https://linux.die.net/man/1/strace>strace</a>.', 'You should study the format options on the cheat sheet and use the examine (x) or print (p) commands. disas may also be useful.']

## Write-up