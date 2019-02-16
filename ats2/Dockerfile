FROM ubuntu:latest

######

# WORKDIR /root
# ENV HOME=/root

COPY \
./ats2-install.sh ${HOME}/ats2-install.sh

RUN \
apt-get -qq update && \
apt-get -qq install -y \
build-essential git wget time gawk libgmp-dev libgc-dev libjson-c-dev && \
rm -rf /var/lib/apt/lists/* && \
apt-get autoremove && apt-get clean

######

ENV PATSHOME=${HOME}/ATS2
ENV PATSCONTRIB=${HOME}/ATS2-contrib
ENV PATH=${PATSHOME}/bin:${PATH}

######

RUN \
echo "export PATSHOME=${HOME}/ATS2" >> ${HOME}/.bashrc && \
echo "export PATH=\${PATSHOME}/bin:\${PATH}" >> ${HOME}/.bashrc && \
echo "export PATSCONTRIB=${HOME}/ATS2-contrib" >> ${HOME}/.bashrc

######

ARG _VERSION=0.3.13
ARG _KND

RUN \
echo $_VERSION && \
echo $_KND && \
bash ats2-install.sh $_VERSION $_KND && \
rm -f /ats2-install.sh

WORKDIR /root

# End of [Dockerfile]
