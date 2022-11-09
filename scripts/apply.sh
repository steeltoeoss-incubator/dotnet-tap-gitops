#!/bin/bash -e

: ${PARAMS_YAML?"Need to set PARAMS_YAML environment variable"}

if [ ! $# -eq 1 ]; then
  echo "Must cluster name as args"
  exit 1
fi

CLUSTER_NAME=$1

kapp deploy -a platform-svcs-gitops -f <(ytt -f common/gitops -f clusters/$CLUSTER_NAME/gitops --data-values-file=$PARAMS_YAML) -y -n default

