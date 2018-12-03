FROM centos:latest

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps
RUN yum -y clean expire-cache
RUN yum -y install deltarpm epel-release && yum clean all && rm -fr /var/cache/yum
RUN yum -y update && rm -fr /var/cache/yum
RUN yum repolist
RUN yum -y groupinstall "Development Tools" && yum -y install zsh wget vim man qemu sudo openssh-clients system-config-kickstart lftp python-pip jq graphviz docker gnutls-devel mkisofs isomd5sum rpm-build yum-utils createrepo \
	curl bsdtar && yum clean all && rm -fr /var/cache/yum
RUN pip install awscli

WORKDIR /tmp

# Install Go
RUN wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz && rm -fv go1.10.3.linux-amd64.tar.gz

# Setup home environment
RUN useradd dev -s /bin/zsh
RUN echo 'dev:devbox' | chpasswd
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

VOLUME /repos
RUN chown -R dev:dev /repos

ENV HOME /home/dev
WORKDIR /home/dev

RUN ln -s /repos /home/dev/repos

USER dev

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN echo 'eval $(ssh-agent -s)' >> .zshrc
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> .zshrc

ENTRYPOINT /bin/zsh 	
