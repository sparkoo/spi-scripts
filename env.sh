#!/bin/sh

set +x

SCRIPT_DIR=$( dirname "${0}" )

SPI_NAMESPACE=spi-system

DEVDIR=${DEVDIR:-${HOME}/dev}
SPI_IMG_BASE=${SPI_IMG_BASE:-quay.io/mvala}

SPIOPERATORDIR=${DEVDIR}/spi-operator
SPIOPERATORIMAGE=${SPI_IMG_BASE}/service-provider-integration-operator

SPIOAUTHDIR=${DEVDIR}/spi-oauth
SPIOAUTHIMAGE=${SPI_IMG_BASE}/service-provider-integration-oauth

export SHARED_SECRET=blabol

# override anything in this script
if [ -f ~/tmp/env-openshift.sh ]; then
  source ~/tmp/env-openshift.sh
fi

getBranch() {
  BRANCH=$( git branch --show-current )
  if [ -z ${BRANCH} ]; then
    BRANCH=$( cat .git/HEAD )
  fi
  echo ${BRANCH}
}
