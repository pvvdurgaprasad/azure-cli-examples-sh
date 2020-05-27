#!/bin/bash
source siteparams-CreateStorageContainer.config
echo $storage
echo $container
az storage container create --account-name $storage -n $container --auth-mode login