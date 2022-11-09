#!/bin/bash -e
terraform -chdir=terraform destroy -auto-approve

PREFIX=$(echo "var.prefix" | terraform -chdir=terraform console -var-file terraform.tfvars | jq -r)

CLUSTERS=$(tmc cluster list -m attached -p attached | grep $PREFIX-tap | awk '{print $(1)}')

for CLUSTER in $CLUSTERS
do
    echo $CLUSTER
    tmc cluster delete $CLUSTER -m attached -p attached --force
done

while [[ $(tmc cluster list -m attached -p attached | grep $PREFIX-tap | awk 'END { print NR }') != 0 ]] ; do
  echo clusters have not yet completed deletion
  tmc cluster list -m attached -p attached | grep $PREFIX-tap | awk '{print $(1)}'
  sleep 5
done
echo clusters deleted
