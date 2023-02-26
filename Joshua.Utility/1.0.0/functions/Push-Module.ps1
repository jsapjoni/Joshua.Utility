function Push-Module {
  [cmdletbinding()]
  param(
    [Parameter()]
    [System.IO.FileInfo]
    $ModulePath
  )
  
  Write-Host "Working with module: " -NoNewline
  Write-Host "$($ModulePath.Name)" -ForegroundColor Green
  Write-Host "Module to push from: " -NoNewline
  Write-Host "$($ModulePath.FullName)" -ForegroundColor Green
  Write-Host "Module to push to: " -NoNewline
  Write-Host "$($env:PSModulePath.Split(";")[0])" -ForegroundColor Green
  
  $IfModuleExist = (Get-ChildItem $env:PSModulePath.Split(";")[0] | Where-Object {$_.Name -eq $ModulePath.Name})
  
  try {
    if ($IfModuleExist -isnot [System.Object]) {
      throw "$(Write-Host 'Could not find module: ' -NoNewline)$(Write-Host -Object $ModulePath.Name -ForegroundColor Red -NoNewline) in directory"
    }
    
    Write-Host "Locating and removing the old module " -NoNewline
    Write-Host "Timestamp: $($IfModuleExist.LastWriteTime)" -ForegroundColor Magenta
    Get-ChildItem $env:PSModulePath.Split(";")[0] | Where-Object {$_.Name -eq $ModulePath.Name} | Remove-Item -Recurse -Force
    Write-Host "Copying module from path to destination " -NoNewline
    Copy-Item -Recurse -Path $ModulePath.FullName -Destination $env:PSModulePath.Split(";")[0]
    $PushedModule = (Get-ChildItem $env:PSModulePath.Split(";")[0] | Where-Object {$_.Name -eq $ModulePath.Name})
    Write-Host "Timestamp: $($PushedModule.LastWriteTime)" -ForegroundColor Magenta
  }
  catch {
    Write-Host " --> Halting Push-Module script" -ForegroundColor Red
  }
}


