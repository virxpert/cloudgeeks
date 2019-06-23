param (
    [stirng]$username,
    [string]$Tenants,
    [string]$HostName,
    [string]$outPutFile,
    [string]$Owner,
    [string]$PageSize = 20
)

$allVirtualMachine = Read-Host "Extrat Report for all VirtualMachine (Yes/No)"
$Tenants = Read-Host "Provide Tenant Name (oaisys, App-habitat or Both)"

if($Tenants -eq 'Both'){
    $Tenants = @(
        "oaisys"
        "app-habitat"
    )
}

if($allVirtualMachine -eq 'No'){
    $Owner = Read-Host "Provide the Machine Owner Name (shortName@domain.local)"
}

$credentials = Get-Credential -UserName $username -Message "Enter Password"
$PassWord = $credentials.GetNetworkCredential().Password

$machine = @()

foreach($Tenant in $Tenants){
    $credentials=@{username=$username;password=$PassWord;tenant=$Tenant}
    <#----------------------Get Auth Token--------------------#>
    $headers=@{"Accept"="application/json"; "Content-Type" = "application/json"}
}
$result = Invoke-RestMethod -Uri "https://$($HostName)/identity/api/tokens" -Method Post -Headers $headers -Body (ConvertTo-Json $credentials)

$Global:token = $result | select -ExcludeProperty id

$headers += @{"Authorization" = "Bearer ${token}"}

if($allVirtualMachine -eq 'Yes'){
    $url = "https://$($HostName)/catalog-service/api/consumer/resources?`$filter=resourceType/name`%20eq`%20'Deployment'&limit=$PageSize"
}else{
    <#-------use this URL if you only want to display machines with specific Owner--------------#>
    $url = "https://$($HostName)/catalog-service/api/consumer/resources?`$filter=owners/ref%20eq%20'$Owner'%20and%20resourceType/name`%20eq`%20'Deployment'&limit=$PageSize"
}

while($url -ne ' '){
    
}