param(
    [Parameter(Mandatory = $true)]
    [string[]]$list
)
$params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
$requestUri = "https://www.gitignore.io/api/$params"

if ($params -eq "list") {
    Write-Host "getting list from "$requestUri" ..."
    Write-Host ""
    Invoke-WebRequest -Uri $requestUri | Select-Object -ExpandProperty content | Write-Host
}
else {
    Write-Host "getting gitignore from "$requestUri" ..."
    Invoke-WebRequest -Uri $requestUri | Select-Object -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}