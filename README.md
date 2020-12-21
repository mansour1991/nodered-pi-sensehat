# nodered-pi-sensehat
fixed.deb is a modified sense-hat_1.2_all.deb package (https://archive.raspberrypi.org/debian/pool/main/s/sense-hat/sense-hat_1.2_all.deb). 
I have removed the postscipt and repackaged again "The postscript trys to enable I2c for you during the image build what you don't want to!"

Before you deploy this container, do the folowing: 

-1 activate I2C by going to the raspberry pi -> sudo raspi-config -> Interface Options -> Enable I2C 

-2 run nodered with this command: 

docker container run --privileged -d -p 6009:1880  --name nodered --restart on-failure   mahmoud91/nodered-pi-sensehat:latest 

ALL the BEsT!!
