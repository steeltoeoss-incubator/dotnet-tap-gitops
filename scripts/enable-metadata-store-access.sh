#!/bin/bash -e

: ${PARAMS_YAML?"Need to set PARAMS_YAML environment variable"}

kubectl config use-context tap-view

export CA=$(kubectl get secret -n metadata-store ingress-cert -o json | jq -r ".data.\"ca.crt\"")
yq e -i '.clusters.build.metadatastore.ingress_ca = env(CA)' $PARAMS_YAML

export CA=$(kubectl get secret -n metadata-store app-tls-cert -o json | jq -r ".data.\"ca.crt\"")
yq e -i '.clusters.view.metadatastore.app_ca = env(CA)' $PARAMS_YAML

export AUTH_TOKEN=`kubectl get secret metadata-store-read-write-client -n metadata-store -ojsonpath="{.data.token}" | base64 -d`
yq e -i '.clusters.build.metadatastore.auth_token = env(AUTH_TOKEN)' $PARAMS_YAML
yq e -i '.clusters.view.metadatastore.auth_token = env(AUTH_TOKEN)' $PARAMS_YAML

echo "Build & View cluster configs updated for metadata access, now you have to apply updates to both."