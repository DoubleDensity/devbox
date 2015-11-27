FROM centos

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps

RUN yum -y install epel-release ; yum clean all
RUN yum repolist
RUN yum -y groupinstall "Development Tools" ; yum clean all
RUN yum -y install libxml2-devel tree ; yum clean all
RUN yum -y install subversion git screen zsh curl wget ; yum clean all

#COPY app /app

ENTRYPOINT /bin/zsh