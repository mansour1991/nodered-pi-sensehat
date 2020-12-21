FROM node:15.4.0-stretch
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    python3-numpy \
    python3-pil \ 
    python-numpy \
    python-pil 
RUN apt-get install -y python-dev
WORKDIR /tmp
# set the version using a variable
ARG RTIMULIB_VERSION=7.2.1-4
# get all th required libraries
RUN curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python-sense-hat_2.2.0-1_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python3-sense-hat_2.2.0-1_armhf.deb
COPY fixed.deb /tmp/fixed.deb 
# install the required libraries
RUN dpkg  -i \
    librtimulib-dev_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib-utils_${RTIMULIB_VERSION}_armhf.deb \
    librtimulib7_${RTIMULIB_VERSION}_armhf.deb \
    python-rtimulib_${RTIMULIB_VERSION}_armhf.deb \
    python3-rtimulib_${RTIMULIB_VERSION}_armhf.deb  \
    python3-sense-hat_2.2.0-1_armhf.deb \
    python-sense-hat_2.2.0-1_armhf.deb \ 
    fixed.deb 
#RUN apt-get install nodered
RUN apt-get install sudo -y 
RUN curl https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered > nodered
RUN chmod +x ./nodered
RUN ./nodered --confirm-install --confirm-root  --confirm-pi  
RUN npm install --global  node-red-node-pi-sense-hat
# cleanups
RUN rm -rf /tmp/* \
  && apt-get clean \ 
  && rm -rf /var/lib/apt/lists/*  
CMD node-red start 


