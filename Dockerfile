FROM centos

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps

RUN yum -y install epel-release ; yum clean all
RUN yum repolist
RUN yum -y groupinstall "Development Tools" ; yum clean all
RUN yum -y install libxml2-devel tree ; yum clean all
RUN yum -y update ; yum -y install zsh wget vim man qemu sudo openssh-clients system-config-kickstart lftp python-pip jq graphviz ; yum clean all
RUN pip install awscli

WORKDIR /tmp
RUN wget https://releases.hashicorp.com/terraform/0.7.5/terraform_0.7.5_linux_amd64.zip
RUN unzip terraform_0.7.5_linux_amd64.zip
RUN cp terraform /usr/local/bin
RUN chmod +x /usr/local/bin/terraform

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
RUN echo "eval $(ssh-agent -s)" >> .zshrc

ENTRYPOINT /bin/zsh 	
