#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

echo ">>> Registering private docker registry: boot.dcos:5000"
sed -i -e '/^ExecStart=/ s/$/ --insecure-registry=boot.dcos:5000/' /usr/lib/systemd/system/docker.service

if [ "${DCOS_PRIVATE_REGISTRY_MIRROR}" == "true" ]; then
    echo ">>> Configuring registry mirror: http://boot.dcos:5000"
    sed -i -e '/^ExecStart=/ s/$/ --registry-mirror=http:\/\/boot.dcos:5000/' /usr/lib/systemd/system/docker.service
fi

echo ">>> Reloading systemd service configs"
systemctl daemon-reload

echo ">>> Restarting docker"
systemctl restart docker
