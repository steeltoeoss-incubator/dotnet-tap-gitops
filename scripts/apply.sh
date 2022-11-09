#!/bin/bash -e

: ${PARAMS_YAML?"Need to set PARAMS_YAML environment variable"}

if [ ! $# -eq 1 ]; then
  echo "Must cluster name as args"
  exit 1
fi

CLUSTER_NAME=$1

kubectl config use-context tap-$CLUSTER_NAME
kapp deploy -a platform-svcs-gitops -f <(ytt -f common/gitops -f clusters/$CLUSTER_NAME/gitops --data-values-file=$PARAMS_YAML) -y -n default

if [ "$CLUSTER_NAME" = "view" ]; then
  ./scripts/enable-metadata-store-access.sh
else
  if [ "$CLUSTER_NAME" = "full" ]; then
    echo "full cluster profile, skipping post processing "
  else
    ./scripts/enable-tap-gui-visibility.sh $CLUSTER_NAME
  fi
fi

