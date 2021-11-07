using namespace System.Net
param($Request, $TriggerMetadata)

#Change <vault-name> to your target Key Vault name
Get-AzKeyVaultSecret -VaultName '<vault-name>'

#Change <secret-user-name> and <secret-pass-name> to names of your target secrets
$usersecret = Get-AzKeyVaultSecret -VaultName '<vault-name>' -Name '<secret-user-name>'
$passsecret = Get-AzKeyVaultSecret -VaultName '<vault-name>' -Name '<secret-pass-name>'

$usersecretValueText = '';

$userssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($usersecret.SecretValue)

try {
	$usersecretValueText = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($userssPtr)
} finally {
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($userssPtr)
}

$passsecretValueText = '';

$passssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passsecret.SecretValue)

try {
	$passsecretValueText = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($passssPtr)
} finally {
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($passssPtr)
}

Write-Host "Username is:" $usersecretValueText
Write-Host "Password is:" $passsecretValueText
$body = "Username is: $usersecretValueText, Password is: $passsecretValueText"
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
StatusCode = [HttpStatusCode]::OK
Body = $body
})