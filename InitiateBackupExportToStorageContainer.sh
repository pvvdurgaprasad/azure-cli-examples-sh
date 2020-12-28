#!/bin/bash
source siteparams-InitiateBackupExportToStorageContainer.config
echo $STORAGE
echo $RESOURCEGROUP
echo $CONTAINER
echo $CONTAINERPERMISSIONS
echo $APPSERVICE
echo $SLOT
accountkey=`az storage account keys list  --account-name $STORAGE --query '[1].value'`
expiry=`date -u -d "1 day" '+%Y-%m-%dT%H:%M:%SZ'`
start=`date -u -d "-1 day" '+%Y-%m-%dT%H:%M:%SZ'`
containersaskey=`az storage container generate-sas --account-name $STORAGE -n $CONTAINER --account-key $accountkey --expiry $expiry --start $start --https-only --permissions $CONTAINERPERMISSIONS | tr -d \"`
containersasurl="https://"$STORAGE".blob.core.windows.net/"$CONTAINER"?"$containersaskey
if [ -z "$SLOT" ]
then
    backupid=`az webapp config backup create -g $RESOURCEGROUP --webapp-name $APPSERVICE --container-url  $containersasurl | jq .backupId | tr -d \"`
    backupstatus=$(az webapp config backup list -g $RESOURCEGROUP --webapp-name $APPSERVICE --query "[?backupId==\`$backupid\`]" | jq .[0].status | tr -d \")
else
    backupid=`az webapp config backup create -g $RESOURCEGROUP --webapp-name $APPSERVICE --slot $SLOT --container-url  $containersasurl | jq .backupId | tr -d \"`
    backupstatus=$(az webapp config backup list -g $RESOURCEGROUP --webapp-name $APPSERVICE --slot $SLOT --query "[?backupId==\`$backupid\`]" | jq .[0].status | tr -d \")
fi
echo $backupstatus
