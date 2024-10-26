FROM ubuntu:14.04

RUN apt-get update && apt-get remove pppoe
RUN apt-get install -y ppp ppp-dev pppoeconf git gcc make vim
RUN apt-get install -y net-tools iputils-ping netcat-traditional
RUN apt-get install -y iptables openssh-server traceroute
RUN mkdir /var/run/sshd
RUN passwd -d root

RUN git clone https://github.com/sklvjz/rp-pppoe-3.11.git && \
    cd rp-pppoe-3.11/src && ./configure && make && make install

RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

COPY pppoe_client.sh /usr/local/bin/pppoe_client.sh
RUN chmod +x /usr/local/bin/pppoe_client.sh

CMD ["/usr/sbin/sshd", "-D"]
