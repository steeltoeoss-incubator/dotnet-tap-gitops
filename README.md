# TAP Gitops

Repo for the GitOps deployment of TAP for the DotNet TSL team.

## Configuring Your Environment to use TAP Instance

1. Install the [Google Cloud SDK](https://cloud.google.com/sdk/).  _Ensure SDK commands like "gcloud" are on your PATH._
1. Install the [`tmc`](https://devecosystems.tmc.cloud.vmware.com/automation/cli) command.
1. Login to [Tanzu Mission Control](https://devecosystems.tmc.cloud.vmware.com/) (TMC). _Ensure your organization is set to "Dev Ecosystems."_
1. Go to the [dotnet-tap-springapps](https://devecosystems.tmc.cloud.vmware.com/clusters/dotnet-tap-springapps/attached/attached/overview) cluster. In the upper right, below your name, select *Actions -> Access this cluster* and follow directions.
1. Go to the [dotnet-experience-containers](https://console.cloud.google.com/artifacts/docker/dotnet-developer-experience/us-central1/dotnet-experience-containers?project=dotnet-developer-experience), select _SETUP INSTRUCTIONS_ and follow directions.
