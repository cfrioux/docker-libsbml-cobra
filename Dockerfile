# Base for libsbml-cobra
#
# VERSION 0.1
#
# build : docker build -t cfrioux/libsbml-cobra .
# usage: docker run -ti -v /path/to/share:/mount/point cfrioux/libsbml-cobra bash
#

FROM ubuntu:latest
MAINTAINER clemence.frioux@inria.fr

# wget and pip
RUN apt-get update && \
    apt-get install wget python-setuptools build-essential python-dev \
                    libblas-dev liblapack-dev libatlas-base-dev zlib1g-dev \
                    gfortran libxml2-dev libxslt1-dev libbz2-dev \
                    libgmp-dev vim -qqy && \
    easy_install pip && apt-get clean && apt-get purge

# glpk
RUN wget ftp://ftp.gnu.org/gnu/glpk/glpk-4.47.tar.gz && \
    tar -xzf glpk-4.47.tar.gz && cd glpk-4.47 && \
    ./configure --prefix=/usr && make && make install && \
    cd ../ && rm -rf glpk-4.47*

# python libs
RUN pip --no-cache-dir install ply numpy scipy && \
    pip --no-cache-dir install lxml && \
    pip --no-cache-dir install python-libsbml cobra glpk
