#!/bin/bash
source siteparams-CreateDevOpsServiceConnection.config
#devops project name
echo $project
#config file name
echo $configurationfile

az devops service-endpoint create --detect true -p $project  --service-endpoint-configuration $configurationfile
