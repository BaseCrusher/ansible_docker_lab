FROM postgres:14-bullseye
COPY ./.internal/files/ssh/ansible_ssh.pub /root/ansible_ssh.pub
COPY ./.internal/files/scripts/node_startup.sh /opt/node_startup.sh
RUN apt update && \
    apt install -y openssh-server sudo python3 python3-pip vim && \
    ln -s /bin/vim /bin/vi && \
    chmod +x /opt/node_startup.sh

ENTRYPOINT ["/bin/sh", "-c", "/opt/node_startup.sh && service ssh start && tail -f /dev/null"]
