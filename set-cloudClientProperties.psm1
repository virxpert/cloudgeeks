function set-cloudClientProperties {
    param (
        [string]$vra_environment
    )

    if ($vra_environment -eq "lab"){
        $env:vra_server
        $env:vra_username
        $env:vra_iaas_server
        $env:vra_keyfile
        $env:vra_tenant
        $env:vra_password

    }elseif ($vra_environment -eq "dev") {
        $env:vra_server
        $env:vra_username
        $env:vra_iaas_server
        $env:vra_keyfile
        $env:vra_tenant
        $env:vra_password

    }elseif ($vra_environment -eq "qa"){
        $env:vra_server
        $env:vra_username
        $env:vra_iaas_server
        $env:vra_keyfile
        $env:vra_tenant
        $env:vra_password

    }elseif ($vra_environment -eq "nonprod"){
        $env:vra_server
        $env:vra_username
        $env:vra_iaas_server
        $env:vra_keyfile
        $env:vra_tenant
        $env:vra_password

    }elseif ($vra_environment -eq "prod"){
        $env:vra_server
        $env:vra_username
        $env:vra_iaas_server
        $env:vra_keyfile
        $env:vra_tenant
        $env:vra_password

    }


    
}