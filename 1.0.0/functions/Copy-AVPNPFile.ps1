function Copy-AVPNPFile {
  [CmdletBinding()]
  param (
    [Parameter()]
    [uri]
    $SourceUrl
    ,
    [Parameter()]
    [uri]
    $TargetPath 
  )
  
  $SPOSiteURL = "{0}/{1}/{2}/{3}/{4}" -f $SourceUrl.OriginalString.Split("/")
  $SourceFile = $SourceUrl.LocalPath
  $TargetPath = $TargetPath.LocalPath
  
  $Obj = [pscustomobject]@{
    "Timestamp" = [datetime]::Now 
    "Status" = ""
    "Source" = $SourceFile
    "Target" = $TargetPath
  }
  
  try 
  {
    Connect-ToTenant -URL $SPOSiteURL 
    Write-Host "Sucessfully connected to site: " -NoNewline
    Write-Host "$SPOSiteURL" -ForegroundColor Green
  }
  catch
  {
    throw "Could not connect to: $SPOSiteURL"
  }
  
  try
  {
    [void] (Copy-PnPFile -SourceUrl $SourceFile -TargetUrl $TargetPath -Force)
    Write-Host " | Successfully copied file from: " -NoNewline
    Write-Host "$SourceUrl" -ForegroundColor Green
    Write-host " | To destination: " -NoNewline
    Write-Host "$TargetPath" -ForegroundColor Green
    $Obj.Status = "Success"
  }
  catch
  {
    throw "Could not perform copy of file: $SourceFile => $TargetPath"
  }
  
  return $Obj
}
