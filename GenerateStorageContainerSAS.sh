#!/bin/bash
source siteparams-GenerateStorageContainerSAS.config
echo $STORAGE
echo $CONTAINER
echo $CONTAINERPERMISSIONS
accountkey=`az storage account keys list  --account-name $STORAGE --query '[1].value'`
expiry=`date -u -d "$EXPIRYDAYS day" '+%Y-%m-%dT%H:%M:%SZ'`
start=`date -u -d "-1 day" '+%Y-%m-%dT%H:%M:%SZ'`
#containersaskey=`az storage container generate-sas --account-name $STORAGE -n $CONTAINER --account-key $accountkey --expiry $expiry --start $start --https-only --permissions $CONTAINERPERMISSIONS --ip $IPADDRESS | tr -d \"`
containersaskey=`az storage container generate-sas --account-name $STORAGE -n $CONTAINER --account-key $accountkey --expiry $expiry --start $start --https-only --permissions $CONTAINERPERMISSIONS | tr -d \"`
containersasurl="https://"$STORAGE".blob.core.windows.net/"$CONTAINER"?"$containersaskey
echo $containersasurl         