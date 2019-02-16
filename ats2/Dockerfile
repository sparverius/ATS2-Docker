FROM ubuntu:latest

######

RUN apt-get -qq update
RUN apt-get -qq install -y build-essential git wget time \
    gawk libgmp-dev libgc-dev libjson-c-dev 
RUN apt-get -y clean

# WORKDIR /home
# ENV HOME=/home

######

ENV PATSHOME=${HOME}/ATS2
ENV PATSCONTRIB=${HOME}/ATS2-contrib
ENV PATH=${PATSHOME}/bin:${PATH}

######

RUN echo "export PATSHOME=${HOME}/ATS2" >> ${HOME}/.bashrc
RUN echo "export PATH=\${PATSHOME}/bin:\${PATH}" >> ${HOME}/.bashrc
RUN echo "export PATSCONTRIB=${HOME}/ATS2-contrib" >> ${HOME}/.bashrc

######

COPY ./ats2-install.sh ${HOME}/ats2-install.sh

ARG _VERSION=0.3.13
ARG _KND

RUN echo $_VERSION && echo $_KND && bash ats2-install.sh $_VERSION $_KND && rm -f ${HOME}/ats2-install.sh

RUN rm -f /ats2-install.sh

# End of [Dockerfile]
