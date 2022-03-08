#!/bin/sh

set +x

SCRIPT_DIR=$( dirname "${0}" )

SPI_NAMESPACE=spi-system

DEVDIR=${DEVDIR:-${HOME}/dev}
PRIVATE_DOCKERREGISTRY=${PRIVATE_DOCKERREGISTRY:-quay.io/mvala}

SPIOPERATORDIR=${DEVDIR}/spi-operator
SPIOPERATORIMAGE=${PRIVATE_DOCKERREGISTRY}/spi-operator

SPIOAUTHDIR=${DEVDIR}/spi-oauth
SPIOAUTHIMAGE=${PRIVATE_DOCKERREGISTRY}/spi-oauth

export SHARED_SECRET=blabol

getBranch() {
  BRANCH=$( git branch --show-current )
  if [ -z ${BRANCH} ]; then
    BRANCH=$( cat .git/HEAD )
  fi
  echo ${BRANCH}
}
