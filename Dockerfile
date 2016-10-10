FROM centos

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps

RUN yum -y install epel-release ; yum clean all
RUN yum repolist
RUN yum -y groupinstall "Development Tools" ; yum clean all
RUN yum -y install libxml2-devel tree ; yum clean all
RUN yum -y install zsh wget vim man qemu sudo openssh-clients system-config-kickstart lftp python-pip ; yum clean all
RUN pip install awscli

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

ENTRYPOINT /bin/zsh 	
