#!/bin/bash
source siteparams-AddDiagSettingsToServicebus.config
#resource group name
echo $RESOURCEGROUP
#storage account name
echo $STORAGE
#database names array ex: ('dbname1' 'dbname2' 'dbname3' 'dbname4' 'dbname5')
echo ${SBNAMES[*]}
#diagnostic settings names array ex: ('diag_dbname1' 'diag_dbname2' 'diag_dbname3' 'diag_dbname4' 'diag_dbname5')
echo ${DIAGNAMES[*]}
#subscription id
echo $SUBSCRIPTIONID
len=${#SBNAMES[@]}
for (( i=0; i<$len; i++ ))
do
 sbname=${SBNAMES[$i]}
 diagname=${DIAGNAMES[$i]}
 resourceid="/subscriptions/$SUBSCRIPTIONID/resourceGroups/$RESOURCEGROUP/providers/Microsoft.ServiceBus/namespaces/$sbname" 
 az monitor diagnostic-settings create -n $diagname --resource $resourceid --storage-account $STORAGE \
 --logs '[
     {
       "category": "OperationalLogs",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     }                         
   ]' \
 --metrics '[
     {
       "category": "AllMetrics",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     }    ]'
done
