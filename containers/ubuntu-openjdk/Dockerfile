FROM ubuntu-minimal:latest

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends default-jdk \
 && apt-get autoclean -y \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]
