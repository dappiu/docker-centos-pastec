FROM centos:7

MAINTAINER Davide Rossi <dappiu@gmail.com>

# Installing dependencies required for compiling Pastec
RUN yum -y clean all && yum -y update && \
    # Adds EPEL repository required for libjsoncpp
    yum -y install epel-release && \
    yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install cmake \
                   jsoncpp-devel \
                   libmicrohttpd-devel \
                   opencv-devel && \
    # Checking out sources and default visual words ORB
    mkdir -p /usr/src && \
    git clone https://github.com/Visu4link/pastec.git /usr/src/pastec && \
    mkdir /pastec && \
    curl -o /pastec/visualWordsORB.tar.gz http://pastec.io/files/visualWordsORB.tar.gz && \
    tar xzf /pastec/visualWordsORB.tar.gz -C /pastec && \
    rm /pastec/visualWordsORB.tar.gz && \
    # Compiling pastec binary
    mkdir /usr/src/pastec/build && \
    cd /usr/src/pastec/build && \
    cmake .. && \
    make && \
    mv pastec /usr/local/bin/pastec && \
    # Throwing away source and build dependencies
    rm -r /usr/src/pastec && \
    yum -y groupremove "Development Tools" && \
    yum -y erase cmake && \
    yum clean all

VOLUME ["/pastec"]

EXPOSE 4212

ENTRYPOINT ["pastec"]
CMD ["/pastec/visualWordsORB.dat"]
