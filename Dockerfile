FROM phusion/baseimage
LABEL maintainer "Jason Sharpee <jason@sharpee.com>"

EXPOSE 8080
ENV settings=/usr/src/nodamation/local/settings.js


RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
      "git", \
      "build-essential", \
      "libssl-dev" ]
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]
RUN [ "curl", "-o-", "https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh",  "|",  "bash" ]
RUN [ "nvm", "install", "node" ]

COPY . /usr/src/nodamation
RUN mkdir /usr/src/nodamation/local
VOLUME ['/usr/src/nodamation/local']

WORKDIR /usr/src/nodamation
CMD [ "bash" ]
