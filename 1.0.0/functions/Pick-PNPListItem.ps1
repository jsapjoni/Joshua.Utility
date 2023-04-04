function Pick-PNPListItem {

  $site = $(Get-PnPWeb).Url

  Write-Host "Pick a list to browse from site: " -NoNewline
  Write-Host "$site" -ForegroundColor Green

  [void]($a = Get-PnPList)
  $list = $a.Title | Invoke-Fzf # Choose a site list

  Write-Host "Selected list: " -NoNewline
  Write-Host "$list " -ForegroundColor Green -NoNewline
  Write-Host "from site: " -NoNewline
  Write-Host "$site" -ForegroundColor Green

  $listitem = (Get-PnPListItem -List $list).FieldValues
  $Document = $listitem | ForEach-Object {$_["FileLeaRef"]} | Invoke-Fzf
  
  Write-Host "Selected document: " -NoNewline
  Write-Host "$Document" -ForegroundColor Green 
}
