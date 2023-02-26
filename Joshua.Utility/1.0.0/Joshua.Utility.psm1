Get-ChildItem -Path "$($MyInvocation.MyCommand.Path | Split-Path)\functions" |
  ForEach-Object {. $_.FullName}
