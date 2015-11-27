FROM centos

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps

RUN yum -y install epel-release ; yum clean all
RUN yum repolist
RUN yum -y groupinstall "Development Tools" ; yum clean all
RUN yum -y install libxml2-devel tree ; yum clean all
RUN yum -y install zsh wget vim man ; yum clean all

# Setup home environment
RUN useradd dev -s /bin/zsh

ENV HOME /home/dev
WORKDIR /home/dev

RUN ln -s /repos /home/dev/repos

USER dev

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ENTRYPOINT /bin/zsh 	