source siteparams-CreateFunctionapp.config
echo $appserviceplan
echo $functionapp
echo $runtime
echo $storage
echo $appinsights
az functionapp create -g $resourcegroup -p $appserviceplan -n $functionapp --runtime $runtime --storage-account $storage --app-insights $appinsights
