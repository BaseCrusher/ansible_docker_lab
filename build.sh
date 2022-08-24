#!/bin/bash
docker-compose down

function check_and_delete_old() {
    if [[ "$(docker images -q $1 2> /dev/null)" ]]; then
        docker rmi $1
    fi
}

check_and_delete_old ansible_admin
docker build -t ansible_admin -f ./.internal/containers/ansible_admin.Dockerfile .

check_and_delete_old ansible_node
docker build -t ansible_node -f ./.internal/containers/ansible_web.Dockerfile .