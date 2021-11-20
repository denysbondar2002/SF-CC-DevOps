This config for the google deployment manager
Fundamentally do these things:
1) Setup a compute instance with Debian 9 OS and one persistent volume (8G)  
2) Update the apt repositories cache and install Nginx as a webserver
3) Write simple text into /var/www/html/index.html.
4) Create a firewall rule which opens 80 ports for our instance which I wrote in 1)