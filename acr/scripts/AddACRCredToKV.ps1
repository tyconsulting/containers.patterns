
#Requires -Modules 'az.resources', 'az.keyvault', 'az.containerregistry'
<#
=======================================================================================
AUTHOR:  Tao Yang
DATE:    08/06/2020
Version: 1.0
Comment: Add Azure Container Registry credential to Key Vault
=======================================================================================
#>
[CmdLetBinding()]
Param (
  [Parameter(Mandatory = $true)][String]$acrResourceGroup,
  [Parameter(Mandatory = $true)][String]$acrName,
  [Parameter(Mandatory = $true)][String]$kvName,
  [Parameter(Mandatory = $true)][String]$acrUserNameSecretName,
  [Parameter(Mandatory = $true)][String]$acrPwSecretName
)
#region main
Write-Output "Adding ACR credential to Key Vault"
Write-Output " - ACR ResourceGroup: $acrResourceGroup"
Write-Output " - ACR Name: $acrName"
Write-Output " - Key Vault Name: $kvName"
Write-Output " - ACR Username Secret Name: $acrUserNameSecretName"
Write-Output " - ACR Password Secret Name: $acrPwSecretName"

Write-Output "Retrieve ACR credential"
#get acr cred
$acrCred = Get-AzContainerRegistryCredential -ResourceGroupName $acrResourceGroup -Name $acrName
$sceAcrUserName = ConvertTo-SecureString -AsPlainText -String $acrCred.username -Force
$secAcrPw = ConvertTo-SecureString -AsPlainText -String $acrCred.password -Force

#Store acr cred in kv
Write-Output "Add ACR $acrName username to Key vault $kvName"
$AddACRUser = Set-AzKeyVaultSecret -VaultName $kvName -Name $acrUserNameSecretName -SecretValue $sceAcrUserName

Write-Output "Add ACR $acrName password1 to Key vault $kvName"
$AddACRPw = Set-AzKeyVaultSecret -VaultName $kvName -Name $acrPwSecretName -SecretValue $secAcrPw
write-output "Done."
#endregion
