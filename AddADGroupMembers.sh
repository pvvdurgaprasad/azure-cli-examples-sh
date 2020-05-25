#!/bin/bash
source siteparams-AddADGroupMembers.config
#ad group name
echo $adgroup
#owner emails array ex: ('email1@company.com' 'email2@company.com' 'email3@company.com')
echo ${owneremails[*]} 
#member emails array ex: ('email1@company.com' 'email2@company.com' 'guestemail#EXT#@AD' 'email3@company.com' 'email4@company.com' 'email5@company.com' 'email6@company.com')
echo ${memberemails[*]}
for i in {0..3}
do
	memberid=`az ad user list --upn "${owneremails[$i]}" | jq .[0].objectId | tr -d \"`
	az ad group owner add -g $adgroup --owner-object-id $memberid
done
for i in {0..6}
do
	memberid=`az ad user list --upn "${memberemails[$i]}" | jq .[0].objectId | tr -d \"`
	az ad group member add -g $adgroup  --member-id $memberid
done