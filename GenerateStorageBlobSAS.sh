#!/bin/bash
source siteparams-GenerateStorageBlobSAS.config
echo $STORAGE
echo $CONTAINER
echo $BLOB
echo $BLOBPERMISSIONS
accountkey=`az storage account keys list  --account-name $STORAGE --query '[1].value'`
expiry=`date -u -d "7 day" '+%Y-%m-%dT%H:%M:%SZ'`
start=`date -u -d "-1 day" '+%Y-%m-%dT%H:%M:%SZ'`
blobsaskey=`az storage blob generate-sas --account-name $STORAGE --container-name $CONTAINER -n $BLOB --account-key $accountkey --expiry $expiry --start $start --https-only --permissions $BLOBPERMISSIONS | tr -d \"`
blobsasurl="https://"$STORAGE".blob.core.windows.net/"$CONTAINER"/"$BLOB"?"$blobsaskey
echo $blobsasurl         