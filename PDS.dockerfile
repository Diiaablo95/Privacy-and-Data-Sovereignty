FROM ubuntu:18.04

ARG LISTENING_PORT

EXPOSE ${LISTENING_PORT}:9001-9002

RUN apt update
RUN apt install -y gnupg2 software-properties-common git
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE7709D068DB5E88
RUN add-apt-repository "deb https://repo.sovrin.org/sdk/deb bionic stable"
RUN apt update
RUN apt install -y libindy python3-pip
RUN pip3 install python3-indy pyjwt web3
RUN pip3 install Werkzeug

COPY PDS/ PDS/
COPY conf/ conf/
COPY pds_with_admin.sh /
RUN chmod +x /pds_with_admin.sh
ENTRYPOINT [ "/pds_with_admin.sh" ]