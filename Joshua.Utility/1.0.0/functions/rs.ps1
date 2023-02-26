function RS ([switch]$PS7, [switch]$PS5) {
  
  # Restart powershell 7 session
  if ($PS7 -eq $true) {
    Invoke-Command { & "pwsh.exe"} -NoNewScope
  }
  
  # Restart windows powershell session
  if ($PS5 -eq $true) {
    Invoke-Command { & "powershell.exe"} -NoNewScope
  }
}
