FROM ubuntu:latest
RUN apt update && apt install -y openssh-server iproute2 ppp pppoe pppoeconf kmod vim python3
COPY ./systemctl3.py /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl
RUN sed -i 's/cut -f1 -d:/cut -f1 -d: | cut -f1 -d@/' /usr/sbin/pppoeconf
# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd
#password for user login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22
# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
