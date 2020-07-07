#!/bin/bash
source siteparams-CreateAlertRulesForServerErrors.config
#resource group
echo $resourcegroup
#site names array ex: ('webapp1' 'api1' 'functionapp1')
echo ${sites[*]} 
#app services array 
echo ${appservices[*]}
#resource names array ex: ('functionapp1')
echo $actionid

len=${#appservices[@]}
for (( i=0; i<$len; i++ ))
do
 alertname="Server errors on ${sites[$i]}"
 echo $alertname 
 scopeid="/subscriptions/563dd366-d7c2-4021-92ad-1c17434ecc15/resourceGroups/$resourcegroup/providers/Microsoft.Web/sites/${appservices[$i]}"
 az monitor metrics alert create -g $resourcegroup -n "$alertname" --description "$alertname" --condition 'total http5xx > 5' --scopes "$scopeid" --action $actionid --disabled false --evaluation-frequency '15m' --severity 1 --window-size '15m'
done