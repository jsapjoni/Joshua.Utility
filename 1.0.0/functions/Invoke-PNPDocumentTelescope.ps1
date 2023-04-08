function Invoke-PNPTelescope {
  param (
    [Parameter()]
    [string]
    $SiteURL
  )
  
  $RandomString = (Get-Random -Count 8 -Minimum 65 -Maximum 90 | ForEach-Object {[char]$_}) -join ""
  $TempFolder = "$env:TMP\$RandomString"
  $SetCurrentWorkdir = $pwd
  [void] (New-Item $TempFolder -ItemType Directory)
  
  Connect-ToTenant -URL $SiteURL
  
  (Get-PnPList -Identity "Documents" | Get-PnPListItem).FieldValues | 
    ForEach-Object { [void] (New-Item "$TempFolder\$($_['FileLeafRef']).json" -Force) ;
      $_ | ConvertTo-Json >> "$TempFolder\$($_['FileLeafRef']).json"}

  Set-Location $TempFolder
  fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
  Set-Location $SetCurrentWorkdir
  Remove-Item $TempFolder -Recurse -Force
}
