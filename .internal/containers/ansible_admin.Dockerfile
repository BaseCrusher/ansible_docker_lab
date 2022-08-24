FROM debian:bullseye
COPY ./.internal/files/ssh/ansible_ssh /home/ansible/.ssh/ansible_ssh
COPY ./.internal/files/scripts/ansible_startup.sh /opt/ansible_startup.sh
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y openssh-client openssh-server python3 python3-pip sudo && \
    pip install ansible && \
    groupadd ansible && useradd -ms /bin/bash -g ansible ansible && \
    usermod -aG sudo ansible && \
    echo "Host *" > "/home/ansible/.ssh/config" && \
    echo " StrictHostKeyChecking no" >> "/home/ansible/.ssh/config" && \
    chown -R ansible:ansible /home/ansible/ && \
    mkdir /ansible && \
    chown ansible:ansible /ansible && \
    echo "cd /ansible" >> /home/ansible/.profile && \
    echo "eval \$(ssh-agent -s) >> /dev/null" >> /home/ansible/.profile  && \
    echo "ssh-add /home/ansible/.ssh/ansible_ssh 2> /dev/null" >> /home/ansible/.profile && \
    chown ansible:ansible /home/ansible/.profile && \
    chmod +x /opt/ansible_startup.sh

ENV PATH="~/.local/bin:${PATH}"
EXPOSE 22
ENTRYPOINT [ "/bin/bash", "-c", "/opt/ansible_startup.sh && service ssh start && tail -f /dev/null"]ß