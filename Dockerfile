FROM ubuntu:14.04

# Install.
# Note: python is required for build process.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y ant vim wget python mysql-client

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN export PATH=$JAVA_HOME/bin:$PATH

# add jce policy
COPY *.jar $JAVA_HOME/jre/lib/security/

# clean up
RUN rm -rf /var/cache/oracle-jdk8-installer
