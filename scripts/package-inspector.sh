#!/bin/bash -e

COMMAND=$1

FOUND=false

if [ "$COMMAND" = "list" ]; then
  tanzu package available list -n tap-install
  FOUND=true
fi

if [ "$COMMAND" = "get" ]; then
    VERSION=$(tanzu package available list -n tap-install -oyaml | yq e '.[] | select(.name=="'$2'") | .latest-version' -)
    tanzu package available get $2/$VERSION -n tap-install --values-schema
    FOUND=true
fi

if [ "$FOUND" = "false" ]; then
  echo "No matching command sent.  Try 'list' or 'get'."
fi
