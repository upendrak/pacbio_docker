FROM ubuntu:18.04
MAINTAINER Upendra Devisetty <upendra@cyverse.org>
LABEL version="5.1.0.26412" description="This Dockerfile is for both smrt and isoseq"

RUN apt-get update && apt-get install -y wget unzip rsync locales

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

RUN wget https://downloads.pacbcloud.com/public/software/installers/smrtlink_5.1.0.26412.zip

RUN unzip -P 9rVkq3HT smrtlink_5.1.0.26412.zip && rm smrtlink_5.1.0.26412.zip

ENV SMRT_ROOT=/smrtlink

ENV SMRT_USER=smrtanalysis

RUN ./smrtlink_5.1.0.26412.run --rootdir $SMRT_ROOT --smrttools-only

ENV PATH=/smrtlink/smrtcmds/bin/:$PATH

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && bash miniconda.sh -b -p /miniconda

ENV PATH=/miniconda/bin/:$PATH

RUN conda config --add channels conda-forge
RUN conda config --add channels defaults
RUN conda config --add channels r
RUN conda config --add channels bioconda

RUN conda install -y isoseq3
