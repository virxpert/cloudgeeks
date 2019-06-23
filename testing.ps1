$header = @{"Accept" = "application/json"}

$header += @{"content-type" = "Application/json"}

Write-Host $header.Keys #| Measure-Object