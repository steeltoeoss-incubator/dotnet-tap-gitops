#!/bin/bash -e
terraform -chdir=terraform validate
terraform -chdir=terraform fmt
terraform -chdir=terraform apply -auto-approve

# Retrieve the list of output commands from terraform output.  This is map of cluster name as keys with command as value
APPLY_TMC_CMDS=$(terraform -chdir=terraform output -json tmc_execution_commands)

# Loop over the cluster names in the output
for cluster in $(echo $APPLY_TMC_CMDS | jq "keys" | jq -r 'join(" ")')
do

  echo "Processing $cluster cluster"

  # Retrieve the kubecontext for the cluster
  az aks get-credentials --name $cluster --resource-group tap --overwrite-existing 

  # Attach the cluster to TMC
  APPLY_TMC_CMD=$(echo $APPLY_TMC_CMDS | jq -r '."'$cluster'"')

  echo "$cluster apply command: $APPLY_TMC_CMD"

  if [ ! -z "$APPLY_TMC_CMD" ] && [ "$APPLY_TMC_CMD" != "missing" ]
  then

    eval "$APPLY_TMC_CMD"

  fi

done
