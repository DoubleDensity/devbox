FROM centos

MAINTAINER Buttetsu Batou <doubledense@gmail.com>

# Install deps

RUN yum -y install epel-release ; yum clean all
RUN yum repolist
RUN yum -y install rpm-build ; yum clean all
RUN yum -y groupinstall "Development Tools" ; yum clean all
RUN yum -y install sudo mkisofs createrepo libxml2-devel tree nmap-ncat ; yum clean all
RUN yum -y --nogpgcheck install openconnect ; yum clean all

RUN mkdir -p /usr/src/redhat/SPECS
RUN mkdir -p /usr/src/redhat/SOURCES
RUN mkdir -p /root/rpmbuild/SPECS
RUN mkdir -p /root/rpmbuild/SOURCES

COPY app /app

RUN cp /app/rpmmacros /root/.rpmmacros

VOLUME /repos
VOLUME /builds

ENTRYPOINT /app/arise.sh