function Pick-PNPListItem {

  $site = $(Get-PnPWeb).Url

  Write-Host "Pick a list to browse from site: " -NoNewline
  Write-Host "$site" -ForegroundColor Green
  
  try {
    [void]($a = Get-PnPList)
    $list = $a.Title | Invoke-Fzf # Choose a site list   
  }
  catch {
    throw "No item was present on list"
  } 

  Write-Host "Selected list: " -NoNewline
  Write-Host "$list " -ForegroundColor Green -NoNewline
  Write-Host "from site: " -NoNewline
  Write-Host "$site" -ForegroundColor Green

  $listitem = (Get-PnPListItem -List $list).FieldValues | ForEach-Object {$_["FileRef"]} | Invoke-Fzf
  
  Write-Host "Selected document: " -NoNewline
  Write-Host "$listitem" -ForegroundColor Green

  return @{"Site" = $site ; "List" = $list ; "Item" = $listitem}
}
