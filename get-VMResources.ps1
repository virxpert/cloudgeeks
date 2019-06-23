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

$Global:token = $result | select -ExpandProperty id

$headers += @{"Authorization" = "Bearer ${token}"}

if($allVirtualMachine -eq 'Yes'){
    $url = "https://$($HostName)/catalog-service/api/consumer/resources?`$filter=resourceType/name`%20eq`%20'Deployment'&limit=$PageSize"
}else{
    <#-------use this URL if you only want to display machines with specific Owner--------------#>
    $url = "https://$($HostName)/catalog-service/api/consumer/resources?`$filter=owners/ref%20eq%20'$Owner'%20and%20resourceType/name`%20eq`%20'Deployment'&limit=$PageSize"
}

while($url -ne ' '){

    $result = Invoke-RestMethod $url -Method Get -Headers $headers

    $result.content | ForEach-Object {
        $id = $_ |select -ExcludeProperty id

        $parent = $_
        $owner = $parent.Owners[0].ref

        $url = "https://$($HostName)/catalog-service/api/consumer/resources?`$filter=parentResource/id`%20eq`%20'${id}'"
        $iresult = Invoke-RestMethod $url -Method Get -Headers $headers

        $iresult.content | where { $_.resourceTypeRef.label -eq "Virtual Machine" }| ForEach-Object {
            $_ | select -ExpandProperty resourceData | ForEach-Object {
                $ipAddress = $_.entries | where { $_.key -eq 'ip_address'}|select -ExpandProperty value | select -ExpandProperty value
                $machineStatus = $_.entries | where { $_.key -eq 'MachineStatus'} |select -ExpandProperty value | select -ExpandProperty value
                $MachineMemory = $_.entries | where { $_.key -eq 'MachineMemory'} |select -ExpandProperty value | select -ExpandProperty value
                $machineBlueprintName = $_.entries | where { $_.key -eq 'MachineBlueprintName'} |select -ExpandProperty value | select -ExpandProperty value
                $machineReservationName = $_.entries | where { $_.key -eq 'MachineReservationName'} |select -ExpandProperty value | select -ExpandProperty value
            }
        }
        <#-----Get Compute and Reservation Status-------------#>
        $rUrl = "https://$($HostName)/reservation-service/api/reservations/?`$filter=name`%20eq`%20'$machineReservationName'&limit=$PageSize"

        $rresult = Invoke-RestMethod $rurl -Method Get -Headers $headers

        $enabled = $rresult.content | select enabled | select enabled
            if($enabled){
                $status = 'True'
            }else {
                $status = 'False'
            }
        $rresult.content |ForEach-Object {
            $_ |select -ExpandProperty extensionData |ForEach-Object{
                $computeResource = $_.entries | where {$_.key -eq 'computeRsource'} | select -ExpandProperty value | Select -ExpandProperty label
            }
        }
        Write-Host ("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11}") -f 
            $_.name, 
            $parent.name,
            $id,
            $owner,
            $machineBlueprintName,
            $machineReservationName,
            $status,
            $ipAddress,
            $MachineMemory,
            $machineStatus,
            $Tenant,
            $computeResource
        $machine += New-Object -TypeName psobject -Property @{
            Owner=$owner;
            MachineName=$_.name;
            MachineId=$id;
            Component=$parent.name;
            Blueprint=$machineBlueprintName;
            Reservation=$machineReservationName;
            ReservationStatus=$status;
            computeResource=$computeResource;
            IPAddress=$ipAddress;
            Memory=$MachineMemory;
            Status=$machineStatus;
            Tenant=$Tenant}
    }
    $url =""
    $result.link |ForEach-Object{
        if($_.rel -eq "next"){
                    $url =$.href
        }
    }
}
$machines | select MachineName, MachineId, Component, Owner, Blueprint, Reservation, ReservationStatus, computeResource, IPAddress, Memory, Status, Tenant| Export-Csv -Path $outPutFile -NoTypeInformation