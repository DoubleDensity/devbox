FROM centos

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps

RUN yum -y install epel-release ; yum clean all
RUN yum repolist
RUN yum -y groupinstall "Development Tools" ; yum clean all
RUN yum -y install libxml2-devel tree ; yum clean all
RUN yum -y install subversion git screen zsh curl wget vim ; yum clean all

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#COPY app /app

ENTRYPOINT /bin/zsh