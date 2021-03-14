FROM       ubuntu:18.04
LABEL maintainer="Tiago de Lima Alves"

RUN apt-get update

RUN apt-get install -y openssh-server vim curl git sudo

RUN apt-get update
RUN apt-get install -y build-essential automake autoconf \
    bison libssl-dev libyaml-dev libreadline6-dev \
    zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev \
    gawk g++ gcc make libc6-dev patch libsqlite3-dev sqlite3 \
    libmysqlclient-dev \ 
    libtool pkg-config libpq-dev nodejs ruby-full

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'Banner /etc/banner' >> /etc/ssh/sshd_config

COPY public/banner /etc/

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -ms /bin/bash app
RUN adduser app sudo
RUN echo 'app:app' |chpasswd

USER app

RUN /bin/bash -l -c "command curl -sSL https://rvm.io/mpapis.asc | gpg --import -"
RUN /bin/bash -l -c "command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -"
RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable"
RUN /bin/bash -l -c "rvm install 2.6.5"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler"
RUN /bin/bash -l -c "gem install rails -v 5.2.3"

USER root

EXPOSE 22
EXPOSE 3000

RUN mkdir /projects
VOLUME /projects

CMD    ["/usr/sbin/sshd", "-D"]

# docker run -d -P --name rails_test -t tiago/ubuntu-ruby:18.04
# ssh root@localhost -p 'port'
# root@localhost's password: 'root'