#!/bin/bash
source siteparams-AddIAMRoleAssignment.config
#subscription id
echo $SUBSCRIPTIONID
#resource groups array ex: ('RESOURCEGROUP1')
echo ${RESOURCEGROUPS[*]} 
#resource types array ex: ('Microsoft.Web/Sites')
echo ${RESOURCETYPES[*]}
#resource names array ex: ('functionapp1')
echo ${RESOURCENAMES[*]}
#roles to be assigned ex: ('Contributor')
echo ${ROLES[*]}
#assignees ex: ('user@company.com')
echo ${ASSIGNEES[*]}
for i in {0..14}
do
	scope="/subscriptions/$SUBSCRIPTIONID/resourceGroups/${RESOURCEGROUPS[$i]}/providers/${RESOURCETYPES[$i]}/${RESOURCENAMES[$i]}"
    az role assignment create --role ${ROLES[$i]} --scope $scope --assignee ${ASSIGNEES[$i]}
done




