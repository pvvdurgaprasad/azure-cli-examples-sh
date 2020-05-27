#!/bin/bash
source siteparams-ExtractResourceGroupWebAppsScheduledBackupStatus.config
#owner emails array ex: ('RG1' 'RG2' 'RG3' 'RG4')
echo ${resourcegroups[*]} 
for resourcegroup in ${resourcegroups[*]} 
do
    reportfile="webappbackups-$resourcegroup.csv"    
    appnamesarr=($(az webapp list -g $resourcegroup --query "[].name" --output tsv))
    for webapp in ${appnamesarr[*]}; do echo $webapp >> $reportfile; az webapp config backup list -g $resourcegroup --webapp-name $webapp --query "reverse(sort_by([?status=='Succeeded'&&scheduled].{id:backupId,filename:blobName,timestamp:created},&id))|[0:2]" --output tsv >> $reportfile; done
done