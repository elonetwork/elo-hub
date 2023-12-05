find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
find . -type d -name ".terraform" -prune -exec rm -rf {} \;
find . -type f -name ".terragrunt.lock.hcl" -prune -exec rm {} \;
find . -type f -name ".terraform.lock.hcl" -prune -exec rm {} \;

az login


resourceGroupName=$(az group list --query '[0].name' --output tsv)
location=$(az group list --query '[0].location' --output tsv)
storageAccountName="pseudo0021"
container1Name="hub"
container2Name="prod"



# Create a resource group
az group create --name $resourceGroupName --location $location

# Create a storage account
az storage account create \
    --resource-group $resourceGroupName \
    --name $storageAccountName \
    --location $location \
    --sku Standard_LRS

# Get the storage account key
accountKey=$(az storage account keys list --resource-group $resourceGroupName --account-name $storageAccountName --query "[0].value" --output tsv)

# Create containers inside the storage account
az storage container create --name $container1Name --account-name $storageAccountName --account-key $accountKey
az storage container create --name $container2Name --account-name $storageAccountName --account-key $accountKey
export TF_VAR_tenant_id=$(az account show --query tenantId --output tsv)

terragrunt  run-all apply  --terragrunt-non-interactive --terragrunt-exclude-dir "**/.terragrunt-cache/**/*" 