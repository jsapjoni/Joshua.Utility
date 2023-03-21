function touche ($Name)
{
	Write-Output -InputObject $null >> $Name ; Write-Host "Created file: $Name"
	nvim ".\$Name" ; Write-Host "Editing file: $Name"
}
