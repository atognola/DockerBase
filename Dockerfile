#FROM docker.tttech.com/lib/base/ubuntu:18.04
FROM ubuntu:18.04
LABEL maintainer="jonatan.sastre@tttech-auto.com"
LABEL version="v1.0"

# switch to root, let the entrypoint drop back to "user"
USER root

RUN sh -c "echo 'dash dash/sh boolean false' | debconf-set-selections" \
&& DEBIAN_FRONTEND=noninteractive apt-get update -y \
&& DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash \
&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
locales nano vim git gosu curl \
gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential libkrb5-dev \
chrpath socat cpio python python-dev python3 python-dev python3-pip python3-pexpect xz-utils debianutils \
iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev libxml2-dev libxslt-dev libssl-dev libffi-dev \
# cleanup
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

COPY py2-requirements.txt ./
COPY py3-requirements.txt ./

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN echo "[global]" >> /etc/pip.conf \
&& echo "index-url = https://artifactory.tttech.com/api/pypi/infrastructure.pypi/simple" >> /etc/pip.conf \
&& echo "index = https://artifactory.tttech.com/api/pypi/infrastructure.pypi/simple" >> /etc/pip.conf \
&& echo "extra-index-url = https://pypi.python.org/simple" >> /etc/pip.conf \
&& echo "trusted-host = artifactory.tttech.com" >> /etc/pip.conf \
&& curl https://bootstrap.pypa.io/get-pip.py | python2 \
&& curl https://bootstrap.pypa.io/get-pip.py | python3 \
&& pip2 install -r py2-requirements.txt  \
&& pip3 install -r py3-requirements.txt

##SDK copy here
#ADD poky-glibc-x86_64-motion-image-minimal-aarch64-toolchain-2.4.2.sh /
#RUN /poky-glibc-x86_64-motion-image-minimal-aarch64-toolchain-2.4.2.sh -y \
#&& rm /poky-glibc-x86_64-motion-image-minimal-aarch64-toolchain-2.4.2.sh

ADD config.sh /usr/local/bin/.config.sh

COPY entrypoint.sh /usr/local/bin/.entrypoint.sh
RUN chmod +x /usr/local/bin/.entrypoint.sh

ENTRYPOINT ["/usr/local/bin/.entrypoint.sh"]
