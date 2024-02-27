# terrafrom


# grafana prerequirements
az provider list --query "[].{Provider:namespace}" -o table
az provider register --namespace Microsoft.Dashboard
az provider show -n Microsoft.Dashboard
