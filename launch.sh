#!/bin/sh

DCOS_VERSION=1.11.6
DCOS_GENERATE_CONFIG_URL=https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh

export DCOS_GENERATE_CONFIG_PATH=installers/dcos/dcos_generate_config-${DCOS_VERSION}.sh
export DCOS_CONFIG_PATH=etc/config.yaml
export DCOS_PRIVATE_REGISTRY=true
export DCOS_JAVA_ENABLED=false

if [ ! -f "${DCOS_GENERATE_CONFIG_PATH}" ]; then
	echo "Downloading ${DCOS_GENERATE_CONFIG_URL} to ${DCOS_GENERATE_CONFIG_PATH}"
	curl "${DCOS_GENERATE_CONFIG_URL}" -o "${DCOS_GENERATE_CONFIG_PATH}"
fi

echo "Provisioning cluster using ${DCOS_CONFIG_PATH}"
vagrant up