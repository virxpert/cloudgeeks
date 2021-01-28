function set-cloudClientProperties {
    param (
        [string]$vra_environment,
        [string]$vra_server,
        [string]$vra_username,
        [string]$vra_iaas_server,
        [string]$vra_tenant,
        [string]$vra_password,
        [string]$vra_keyfile
        )

    if ($vra_environment -eq "lab"){
        $env:vra_server = $vra_server
        $env:vra_username = $vra_username
        $env:vra_iaas_username = $vra_username
        $env:vra_iaas_server = $vra_iaas_server
        $env:vra_keyfile = $vra_keyfile
        $env:vra_iaas_keyfile = $vra_keyfile
        $env:vra_tenant = $vra_tenant
        $env:vra_password = $vra_password

    }elseif ($vra_environment -eq "dev") {
        $env:vra_server = $vra_server
        $env:vra_username = $vra_username
        $env:vra_iaas_username = $vra_username
        $env:vra_iaas_server = $vra_iaas_server
        $env:vra_keyfile = $vra_keyfile
        $env:vra_iaas_keyfile = $vra_keyfile
        $env:vra_tenant = $vra_tenant
        $env:vra_password = $vra_password

    }elseif ($vra_environment -eq "qa"){
        $env:vra_server = $vra_server
        $env:vra_username = $vra_username
        $env:vra_iaas_username = $vra_username
        $env:vra_iaas_server = $vra_iaas_server
        $env:vra_keyfile = $vra_keyfile
        $env:vra_iaas_keyfile = $vra_keyfile
        $env:vra_tenant = $vra_tenant
        $env:vra_password = $vra_password

    }elseif ($vra_environment -eq "nonprod"){
        $env:vra_server = $vra_server
        $env:vra_username = $vra_username
        $env:vra_iaas_username = $vra_username
        $env:vra_iaas_server = $vra_iaas_server
        $env:vra_keyfile = $vra_keyfile
        $env:vra_iaas_keyfile = $vra_keyfile
        $env:vra_tenant = $vra_tenant
        $env:vra_password = $vra_password

    }elseif ($vra_environment -eq "prod"){
        $env:vra_server = $vra_server
        $env:vra_username = $vra_username
        $env:vra_iaas_username = $vra_username
        $env:vra_iaas_server = $vra_iaas_server
        $env:vra_keyfile = $vra_keyfile
        $env:vra_iaas_keyfile = $vra_keyfile
        $env:vra_tenant = $vra_tenant


    }


    
}