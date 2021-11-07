$role = Get-AzureADMSRoleDefinition -Id "62e90394-69f5-4237-9190-012177145e10"
$rolemembersid = (Get-AzureADMSRoleAssignment -Filter "roleDefinitionId eq '$($role.Id)'").PrincipalID
$tokenrevoke=@()
foreach($i in $rolemembersid){Revoke-AzureADUserAllRefreshToken -ObjectId $i}