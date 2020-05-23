#!/bin/bash
source Siteparams-AddDiagSettingsToDatabases.sh
#resource group name
$resourcegroup
#storage account name
$storage
#database names array ex: ('dbname1' 'dbname2' 'dbname3' 'dbname4' 'dbname5')
$dbname
#diagnostic settings names array ex: ('diag_dbname1' 'diag_dbname2' 'diag_dbname3' 'diag_dbname4' 'diag_dbname5')
$diagname
#sql server name
$sqlserver
#subscription id
$subscriptionid
for i in {0..4}
do
 resourceid="/subscriptions/$subscriptionid/resourceGroups/$resourcegroup/providers/Microsoft.Sql/servers/$sqlserver/databases/${dbname[$i]}" 
 az monitor diagnostic-settings create -n ${diagname[$i]} --resource $resourceid --storage-account $storage \
 --logs '[
     {
       "category": "SQLInsights",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "AutomaticTuning",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "QueryStoreRuntimeStatistics",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "QueryStoreWaitStatistics",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "Errors",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "DatabaseWaitStatistics",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "Timeouts",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "Blocks",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "Deadlocks",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "DevOpsOperationsAudit",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     }                         
   ]' \
 --metrics '[
     {
       "category": "Basic",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "InstanceAndAppAdvanced",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     },
     {
       "category": "WorkloadManagement",
       "enabled": true,
       "retentionPolicy": {
         "enabled": false,
         "days": 365
       }
     }             
    ]'
done
