source siteparams-AddWebappBackupSchedule.config
echo ${WEBAPPS[*]}
echo ${RESOURCEGROUPS[*]}
echo ${STORAGEACCOUNTS[*]}
echo $FREQUENCY
echo $RETENTIONDAYS
len=${#WEBAPPS[@]}
for (( i=0; i<$len; i++ ))
do
    WEBAPP=${WEBAPPS[$i]}
    RESOURCEGROUP=${RESOURCEGROUPS[$i]}
    STORAGE=${STORAGEACCOUNTS[$i]}
    CONTAINER=$WEBAPP
    echo "$WEBAPP - $RESOURCEGROUP - $STORAGE - $CONTAINER"
    az storage container create -n $CONTAINER --account-name $STORAGE --auth-mode login
    accountkey=`az storage account keys list  --account-name $STORAGE --query '[1].value'`
    expiry=`date -u -d "5 year" '+%Y-%m-%dT%H:%M:%SZ'`
    start=`date -u -d "-1 day" '+%Y-%m-%dT%H:%M:%SZ'`
    containersaskey=`az storage container generate-sas --account-name $STORAGE -n $CONTAINER --account-key $accountkey --expiry $expiry --start $start --https-only --permissions $CONTAINERPERMISSIONS | tr -d \"`
    containersasurl="https://"$STORAGE".blob.core.windows.net/"$CONTAINER"?"$containersaskey
    az webapp config backup update -g $RESOURCEGROUP --webapp-name $WEBAPP --container-url $containersasurl --frequency $FREQUENCY --retain-one true --retention $RETENTIONDAYS
done    