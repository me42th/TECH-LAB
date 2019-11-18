FROM     ubuntu:16.04
LABEL maintainer="bitard [dot] michael [at] gmail [dot] com"

# Install basics
RUN apt-get update &&  \
    apt-get install -y git wget curl unzip build-essential ruby ruby-dev ruby-ffi gcc make && \
    curl --retry 3 -SLO "http://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.gz" && \
    tar -xzf "node-v10.13.0-linux-x64.tar.gz" -C /usr/local --strip-components=1 && \
    rm "node-v10.13.0-linux-x64.tar.gz" && \
    npm install -g npm@"6.4.1" && \
	npm install -g ionic && \
	npm cache clear --force && \
    git config --global user.email "david.meth@hotmail.com" && \
    git config --global user.name "me42th" 
    
EXPOSE 8100 35729

CMD ["ionic", "serve"]