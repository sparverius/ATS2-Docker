FROM ubuntu:latest

RUN apt-get -qq update
RUN apt-get -qq install -y gcc make git wget time gawk \
    automake libgmp-dev libgc-dev libjson-c-dev unzip
RUN apt-get -y clean


WORKDIR /home
ENV HOME=/home


ENV GCC=gcc

######

ENV ATSVER=0.2.12
ENV ATSPACK=ats-lang-anairiats-${ATSVER}
ENV ATSPACKTGZ=${ATSPACK}.tgz

######

ENV ATSLANGURL_srcfg=http://sourceforge.net/projects/ats-lang
ENV ATSLANGURL_github=http://ats-lang.github.io

######

RUN wget -q ${ATSLANGURL_github}/ATS-Anairiats/${ATSPACKTGZ}
RUN tar -zxf ${ATSPACKTGZ}

ENV ATSHOME=$HOME/$ATSPACK
ENV ATSHOMERELOC=ATS-${ATSVER}

######

RUN cd ${ATSHOME} && ./configure && make CC=${GCC} all_ngc

RUN cd $ATSHOME/bootstrap1 && rm -f *.o
RUN cd $ATSHOME/ccomp/runtime/GCATS && make && make clean

ENV PATH=${ATSHOME}/bin:${PATH}

RUN echo "export ATSHOME=${HOME}/${ATSPACK}" >> ${HOME}/.bashrc
RUN echo "export ATSHOMERELOC=ATS-${ATSVER}" >> ${HOME}/.bashrc

RUN atsopt -v

RUN rm ${ATSPACKTGZ}

# End of [Dockerfile]
