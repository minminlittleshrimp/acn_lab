FROM ubuntu:latest

# Package installation
RUN apt-get update 
RUN apt-get install -y openssh-server
RUN apt-get install -y pppoe pppoeconf
RUN apt-get install -y net-tools iputils-ping netcat-traditional
RUN apt-get install -y kmod vim python3

# systemctl replacement
COPY ./systemctl3.py /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

# pppoe setup
RUN sed -i 's/cut -f1 -d:/cut -f1 -d: | cut -f1 -d@/' /usr/sbin/pppoeconf

# SSH configuration
RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd

# Pass for user login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
