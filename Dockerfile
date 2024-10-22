FROM ubuntu:latest

RUN apt-get update 
RUN apt-get install -y openssh-server
RUN apt-get install -y pppoe pppoeconf
RUN apt-get install -y iputils-ping net-tools

# Config ssh
RUN mkdir /var/run/sshd
RUN echo 'root:acn2024' | chpasswd

# Pass for user login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
