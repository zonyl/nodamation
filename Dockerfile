FROM phusion/baseimage
LABEL maintainer "Jason Sharpee <jason@sharpee.com>"
LABEL org.label-schema.vendor="zonyl" \
  org.label-schema.url="https://github.com/zonyl/nodamation" \
  org.label-schema.name="Nodamation" \
  org.label-schema.version="1" \
  org.label-schema.vcs-url="github.com:zonyl/nodamation.git" \
  org.label-schema.vcs-ref="" \
  org.label-schema.build-date="2" \
  org.label-schema.docker.schema-version="1.0"
EXPOSE 8080
ENV NODAMATION_SETTINGS=/usr/src/nodamation/local/settings.js

#Node JS 6.x
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
      "git", \
      "build-essential", \
      "libssl-dev", \
      "nodejs" ]
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]
RUN curl -o- https://raw.githubusercontent.com/xtuple/nvm/master/install.sh | bash
RUN export
RUN [ "nvm", "install", "v6.10.0" ]
RUN export

COPY . /usr/src/nodamation
RUN mkdir /usr/src/nodamation/local
VOLUME ['/usr/src/nodamation/local']

RUN useradd -c 'Nodamation User' -m -d /home/nodamation -s /bin/bash nodamation
RUN chown -R nodamation.nodamation /usr/src/nodamation
USER nodamation
ENV HOME /home/nodamation
RUN echo "$HOME"
RUN [ "nvm", "install", "v6.10.0" ]
RUN export
#RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
#RUN export HOME="/home/nodamation"
#RUN export NVM_DIR="$HOME/.nvm"
#RUN exec bash
#RUN export
#RUN source /home/nodamation/.bashrc
#RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
WORKDIR /usr/src/nodamation
#RUN [ "sh", "/usr/src/nodamation/nvm_env.sh" ]
#RUN export
#RUN [ "nvm", "install", "node" ]

CMD [ "bash" ]
