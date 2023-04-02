function Connect-ToTenant {
  [Alias("ctt")]
  param(
    [Parameter()]
    [String]
    $SetPath
    ,
    [Parameter()]
    [String]
    $URL
  )
  
  if ($PSBoundParameters.ContainsKey("SetPath")){
    if ($SetPath -notlike "*ctt-*.conf"){
      throw
    }
    [System.Environment]::SetEnvironmentVariable('TENANT_CONF_PATH', $SetPath, 'User') 
    Write-Host "Set path for $SetPath"
    Write-Host "Please restart powershell session to take effect"
  }
  
  try 
  {
    $Config = Get-Content -Path $env:TENANT_CONF_PATH
  }
  catch 
  {
    Write-Host "No set values for: $env:TENANT_CONF_PATH"
    Write-Host "Please use filepath and set to config file"
    Throw
  }
  
  $CLIENT_ID = ($Config | Where-Object {$_ -like "CLIENT_ID*"}).Split("=")[1]
  $TENANT_ID = ($Config | Where-Object {$_ -like "TENANT_ID*"}).Split("=")[1]
  $KEY_PATH = ($Config | Where-Object {$_ -like "KEY_PATH*"}).Split("=")[1]
  
  if ($PSBoundParameters.ContainsKey("URL")){
    try
    {
      Write-Host "Attemping to connect to site: " -NoNewline
      Write-Host "$URL" -ForegroundColor Green 
      Connect-PnPOnline -Url $URL -ClientId $CLIENT_ID -Tenant $TENANT_ID -CertificatePath $KEY_PATH
      Write-Host "Successfully connected to site: " -NoNewline
      Write-Host "$URL" -ForegroundColor Green 
    }
    catch 
    {
      Write-Host "Could not connect"
      throw
    }
  }
}
