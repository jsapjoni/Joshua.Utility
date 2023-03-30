Function Invoke-RandomFileCreation {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$true)]
    [int]
    $NumberOfFolders
    ,
    [Parameter(Mandatory=$true)]
    [int]
    $NumberOfFiles
    ,
    [Parameter(Mandatory=$true)]
    [string]
    $FolderPath
  )
  
  if ((Test-Path -Path $FolderPath) -eq $false){
    Write-Host "Could not find $FolderPath .. " -NoNewline
    Write-Host "Aborting script" -ForegroundColor Red
    throw
  }
  
  $RandomUser = ((Invoke-WebRequest "https://randomuser.me/api/?results=$($NumberOfFiles)" ).Content | ConvertFrom-Json).Results.Name
  
  # Create the folders
  for ($i = 0; $i -lt $NumberOfFolders; $i++) {
    $RandomLetter = Get-Random -Count 8 -Minimum 65 -Maximum 90 | ForEach-Object {[char]$_} | Join-String
    $FolderName = "$($RandomLetter)$($RandomLetter)-000$i"
    $Null = New-Item -Path "$FolderPath\$FolderName" -ItemType Directory
    Write-Host "Generated folder: " -NoNewline
    Write-Host "$FolderName" -ForegroundColor Green
    
    for ($n = 0; $n -lt $NumberOfFiles; $n++) {
      $FileName = "$($RandomUser[$n].first)$($RandomUser[$n].last)-content.txt"
      $RandNum = Get-Random -Minimum 1 -Maximum 5
      (Invoke-WebRequest -Uri "https://baconipsum.com/api/?type=all-meat&paras=$($RandNum)&start-with-lorem=1").content | ConvertFrom-Json >> "$FolderPath\$FolderName\$FileName"
      Write-Host " | Created file: " -NoNewline
      Write-Host "$FileName" -ForegroundColor Green
    }
  }
}  
