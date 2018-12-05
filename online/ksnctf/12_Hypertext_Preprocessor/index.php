<?php
    //  Flag is in this directory.
    date_default_timezone_set('UTC');
    
    $t = '2012:1823:20:';
    $t .= date('y:m:d:H:i:s');
    for($i=0;$i<4;$i++)
        $t .= sprintf(':%02d',mt_rand(0,59));
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Clock</title>
    <style>
      body
      {
        background: black;
      }
      p
      {
        color: red;
        font-size: xx-large;
        font-weight: bold;
        text-align: center;
        margin-top: 200px;
      }
    </style>
  </head>
  <body>
    <p><?php echo $t; ?></p>
  </body>
</html>