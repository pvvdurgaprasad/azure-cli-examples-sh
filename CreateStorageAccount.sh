#!/bin/bash
source siteparams-CreateStorageAccount.config
echo $storage
echo $resourcegroup
echo $location
az storage account create -n $storage -g $resourcegroup -l $location --sku Standard_LRS