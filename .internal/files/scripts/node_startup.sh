#!/bin/bash
groupadd $GROUP
useradd -ms /bin/bash -g $GROUP $USER
usermod -aG sudo $USER
mkdir -p "/home/$USER/.ssh/"
touch "/home/$USER/.ssh/authorized_keys"
chmod 600 "/home/$USER/.ssh/authorized_keys"
cat /root/ansible_ssh.pub > "/home/$USER/.ssh/authorized_keys"
chown -R "$USER:$GROUP" "/home/$USER"
echo "$USER:$PASSWORD" | chpasswd

if [[ $REQUIERE_SUDO_PASS != "TRUE" ]]; then
    echo "$USER ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
fi