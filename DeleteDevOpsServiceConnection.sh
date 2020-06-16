#!/bin/bash
source siteparams-DeleteDevOpsServiceConnection.config
#devops project name
echo $project
#service connection name
echo $serviceconnection

scid=$(az devops service-endpoint list --detect true -p $project --query "[?name==\`$serviceconnection\`]"| jq .[0].id | tr -d \")
az devops service-endpoint delete --detect true -p $project --id $scid --deep -y
