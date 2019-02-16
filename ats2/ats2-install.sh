#!/usr/bin/env sh

######
#
# A shell script for
# installing ATS-Postiats + utils
#
######
#
# Author: Hongwei Xi
# Authoremail: gmhwxiATgmailDOTcom
#
######

# sudo apt-get update
#
# Installing gcc
# sudo apt-get install -y gcc
# Installing git
# sudo apt-get install -y git
#
# sudo apt-get install -y build-essential
# sudo apt-get install -y libgmp-dev libgc-dev

# sudo apt-get install -y libjson-c-dev

######

export PATSHOME=${HOME}/ATS2
export PATSCONTRIB=${HOME}/ATS2-contrib
export PATH=${PATSHOME}/bin:${PATH}

######

# echo "export PATSHOME=${HOME}/ATS2" >> ${HOME}/.bashrc
# echo "export PATSCONTRIB=${HOME}/ATS2-contrib" >> ${HOME}/.bashrc
# echo "export PATH=\${PATSHOME}/bin:\${PATH}" >> ${HOME}/.bashrc

######

_dl_knd() {
    local REL_VERSION="$1"
    local REL_KND="$2"
    local _url=https://sourceforge.net/projects/ats2-lang/files/ats2-lang/ats2-postiats-${REL_VERSION}/ATS2-Postiats-${REL_KND}-${REL_VERSION}.tgz/download

    cd ${HOME}
    wget -O ${HOME}/ATS2-Postiats-${REL_KND}-${REL_VERSION}.tgz "$_url" 
    tar -xf ATS2-Postiats-${REL_KND}-${REL_VERSION}.tgz
    rm -f ATS2-Postiats-${REL_KND}-${REL_VERSION}.tgz
    mv ATS2-Postiats-${REL_KND}-${REL_VERSION} ATS2
}

######

_install_ats() {
    (cd ${PATSHOME} && sudo make install)    
}

_parsing_constraints() {
    (cd ${PATSHOME}/contrib/ATS-extsolve && time make DATS_C)
}

_patsolve_z3() {
    (cd ${PATSHOME}/contrib/ATS-extsolve-z3 && time make all)
    (cd ${PATSHOME}/contrib/ATS-extsolve-z3 && mv -f patsolve_z3 ${PATSHOME}/bin)
}

_patsolve_smt2() {
    (cd ${PATSHOME}/contrib/ATS-extsolve-smt2 && time make all)
    (cd ${PATSHOME}/contrib/ATS-extsolve-smt2 && mv -f patsolve_smt2 ${PATSHOME}/bin)
}

_parsemit() {
    (cd ${PATSHOME}/contrib/CATS-parsemit && time make all)
}

_atscc2js() {
    (cd ${PATSHOME}/contrib/CATS-atscc2js && time make all)
    (cd ${PATSHOME}/contrib/CATS-atscc2js && mv -f bin/atscc2js ${PATSHOME}/bin)
}

_atscc2php() {
    (cd ${PATSHOME}/contrib/CATS-atscc2php && time make all)
    (cd ${PATSHOME}/contrib/CATS-atscc2php && mv -f bin/atscc2php ${PATSHOME}/bin)
}

_atscc2py3() {
    (cd ${PATSHOME}/contrib/CATS-atscc2py3 && time make all)
    (cd ${PATSHOME}/contrib/CATS-atscc2py3 && mv -f bin/atscc2py3 ${PATSHOME}/bin)
}

_atscc2erl() {
    apt-get install -y erlang
    (cd ATS2/contrib/CATS-atscc2erl && time make all)
    (cd ATS2/contrib/CATS-atscc2erl && mv -f bin/atscc2erl ${PATSHOME}/bin)
}


_build_all() {
    # Building patsopt + patscc
    cd ${PATSHOME} && ./configure && time make all

    # Installing patscc and patsopt
    # _install_ats

    # For parsing constraints 
    # _parsing_constraints

    # For building patsolve_z3
    # _patsolve_z3

    # For building patsolve_smt2
    # _patsolve_smt2

    # For parsing C code generated from ATS source
    _parsemit

    # For building atscc2js
    _atscc2js

    # For building atscc2php
    _atscc2php

    # For building atscc2py3
    _atscc2py3

    # For building atscc2erl
    # _atscc2erl
}

_help() {
    echo "$(basename "$0") version [knd]"
    exit 1
}

_main() {
    [ -z "$1" ] && _help

    local _version="$1"
    local _opt_knd="$2"

    case "$_opt_knd" in
	int) _dl_knd "$_version" "int"
		;;
	gmp) _dl_knd "$_version" "gmp"
		;;
	*) git clone --depth 1 git://git.code.sf.net/p/ats2-lang/code ${HOME}/ATS2
	   ;;
    esac

    git clone --depth 1 https://github.com/githwxi/ATS-Postiats-contrib.git ${HOME}/ATS2-contrib

    _build_all

}

_main "$1" "$2"
patsopt -v
