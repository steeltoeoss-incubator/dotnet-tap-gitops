#!/usr/bin/env bash

cluster=$(basename $0)
echo -n "create cluster $cluster? "
read response
response=${response^^}
[[ "$response" == "Y" ]] || [[ "$response" == "YES" ]] || exit
echo creating cluster $cluster
echo

cluster_version="1.25.6-gke.1000"

gcloud beta container \
  clusters create "$cluster" \
  --project "dotnet-developer-experience" \
  --zone "us-central1-c" \
  --no-enable-basic-auth \
  --cluster-version "$cluster_version" \
  --release-channel "regular" \
  --machine-type "e2-standard-4" \
  --image-type "COS_CONTAINERD" \
  --disk-type "pd-balanced" \
  --disk-size "100" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --max-pods-per-node "110" \
  --num-nodes "5" \
  --logging=SYSTEM,WORKLOAD \
  --monitoring=SYSTEM \
  --enable-ip-alias \
  --network "projects/dotnet-developer-experience/global/networks/default" \
  --subnetwork "projects/dotnet-developer-experience/regions/us-central1/subnetworks/default" \
  --no-enable-intra-node-visibility \
  --default-max-pods-per-node "110" \
  --no-enable-master-authorized-networks \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
  --enable-autoupgrade \
  --enable-autorepair \
  --max-surge-upgrade 1 \
  --max-unavailable-upgrade 0 \
  --enable-shielded-nodes \
  --node-locations "us-central1-c"
