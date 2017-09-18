## simplesqliiiii 200pt

### Problem
> can you login to admin??
> <http://133.242.234.142/simplesqli/>


### Answer
Simple SQL injection. Input `' OR 1=1--` to user input form.

| Component | Effect |
|:-----------:|:------------|
| ' | Exit the string constant. |
| OR 1=1 | Twist the search condition and always make it TRUE. |
| -- | Ignore the contents after that as comments. |


![simplesqli image](https://github.com/takuzoo3868/noctf/blob/master/12_simplesqliiiii/shot01.JPG?raw=true)


### Flag
Sorry, I forgot to confirm at competition time.
