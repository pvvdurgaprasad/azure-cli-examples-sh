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
len=${#RESOURCENAMES[@]}
for (( i=0; i<$len; i++ ))
do
    resourcegroup=${RESOURCEGROUPS[$i]}
    type=${RESOURCETYPES[$i]}
    name=${RESOURCENAMES[$i]}
    role=${ROLES[$i]}
    assignee=${ASSIGNEES[$i]}
	scope="/subscriptions/$SUBSCRIPTIONID/resourceGroups/$resourcegroup/providers/$type/$name"
    az role assignment create --role $role --scope $scope --assignee $assignee
done