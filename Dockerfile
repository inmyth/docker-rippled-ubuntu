FROM ubuntu:16.10

RUN apt-get -y update
RUN apt-get -y install yum-utils alien

# Install essentials
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget iptables && \
rm -rf /var/lib/apt/lists/*
	
#Install Rippled (alien is installed on top)
RUN rpm -Uvh https://mirrors.ripple.com/ripple-repo-el7.rpm
RUN yumdownloader --enablerepo=ripple-stable --releasever=el7 rippled
RUN rpm --import https://mirrors.ripple.com/rpm/RPM-GPG-KEY-ripple-release && rpm -K rippled*.rpm
RUN alien -i --scripts rippled*.rpm && rm rippled*.rpm


# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

COPY rippled.cfg /opt/ripple/etc/

EXPOSE 5006
# Define default command.

ENTRYPOINT  /opt/ripple/bin/rippled  --conf=/opt/ripple/etc/rippled.cfg --start -a


