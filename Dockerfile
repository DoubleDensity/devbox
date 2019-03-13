FROM centos:latest

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps
RUN yum -y clean expire-cache
RUN yum -y install deltarpm epel-release centos-release-scl && yum clean all && rm -fr /var/cache/yum
RUN yum -y update && rm -fr /var/cache/yum
RUN yum -y groupinstall "Development Tools" && yum -y install zsh wget vim man sudo lftp rh-python36-python-pip python-paramiko python-dpath jq rpm-build yum-utils createrepo \
	curl bsdtar && yum clean all && rm -fr /var/cache/yum

# Setup home environment
RUN useradd dev -s /bin/zsh
RUN echo 'dev:devbox' | chpasswd
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/dev
WORKDIR /home/dev

USER dev

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN echo 'eval $(ssh-agent -s)' >> .zshrc
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> .zshrc
RUN echo 'alias python=/opt/rh/rh-python36/root/usr/bin/python' >> .zshrc

ENTRYPOINT /bin/zsh
