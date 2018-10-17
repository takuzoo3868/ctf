## bin~w 200pt


### Problem
> <https://drive.google.com/open?id=0B1ICKh3eQEdFaHF0eldUWG5feHc>

### Answer
Check the file type of `b.jpg`.

```bash
$ file b.jpg
b.jpg: JPEG image data, JFIF standard 1.01, aspect ratio, density 72x72, segment length 16, progressive, precision 8, 480x640, frames 3
```

Just use strings command in linux.

```bash
$ strings b.jpg | grep NoCTF
NoCTF{5trings_4nd_gr3p}
```

### Flag
`NoCTF{5trings_4nd_gr3p}`
