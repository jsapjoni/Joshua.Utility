function Plush-Module {
  param(
    [Parameter()]
    [System.IO.FileInfo]
    $ModulePath
  )
  try 
  {
    Push-Module -ModulePath $ModulePath
  }
  catch 
  {
    Write-Host " --> Halting Update-Module script" -ForegroundColor Red
    throw   
  }
  
  Write-Host "Importing module " -NoNewline
  Write-Host "$($ModulePath.Name) " -ForegroundColor Magenta -NoNewline
  Write-Host "from " -NoNewline
  Write-Host "$($env:PSModulePath.Split(";")[0])" -ForegroundColor Green
  
  Import-Module -Name $ModulePath.Name -Force
}
