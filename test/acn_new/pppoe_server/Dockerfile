FROM ubuntu:14.04

# Install necessary packages, including GCC
RUN apt-get update
#RUN apt-get remove pppoe
#RUN apt-get install -y ppp ppp-dev pppoeconf git gcc make vim
#RUN apt-get install -y net-tools iputils-ping netcat-traditional
RUN apt-get install -y iptables kmod python3
RUN apt-get install -y openssh-server

# Clone and install rp-pppoe from GitHub
#RUN git clone https://github.com/sklvjz/rp-pppoe-3.11.git && \
#    cd rp-pppoe-3.11/src && ./configure && make && make install

# SSH configuration
RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd

# Pass for user login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Copy and execute setup script
#COPY pppoe_server.sh /usr/local/bin/pppoe_server.sh
#RUN chmod +x /usr/local/bin/pppoe_server.sh

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
