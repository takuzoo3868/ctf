## braille 50pt

### Problem
> <https://drive.google.com/open?id=0B1ICKh3eQEdFamlNWG5aX1pqV00>  
> lowercase  
> Flag format: "NoCTF{xxxxxxx}".  

### Answer
> Braille is a tactile writing system used by people who are blind or visually impaired.

```bash
$ cat braille.txt

.. .- .- .. -. -. .- .- .. -. .- .- .-
.- .- -- .. .- .- .- .. -. .- .- .- -.
-- .- -- -- -- .- -- .- -- -- .- .- --
```

Check this [URL](https://www.pharmabraille.com/pharmaceutical-braille/the-braille-alphabet/).  
When replacing this text, you can read `flagisbrdille`, but `d` and `4`(Usually add a number indicator before the number...) are the same symbols, so `br4ille` was the correct answer.

### Flag
`NoCTF{br4ille}`
