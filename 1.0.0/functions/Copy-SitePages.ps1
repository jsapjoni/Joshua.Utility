<#
.SYNOPSIS
    .
.DESCRIPTION
    This function is used to move site pages and its assets to another site.
.PARAMETER UriAspxFile
    Direct URI of .aspx file you want to move between sites.
.PARAMETER DestinationSite
    Destination URI.
    For example "https://tenant.sharepoint.com/sites/examplesite/SitePages"
    For example "https://1ys8cf.sharepoint.com/sites/SaputilHomePage/Shared%20Documents/benefits"
.EXAMPLE
    <Description of example>
.NOTES
    Author: Joshua Saputil
    Date:   02.04.2023    
#>

function Copy-SitePages {
  [cmdletbinding()]
  param (
    [parameter()]
    [uri]
    $UriAspxFile
    ,
    [parameter()]
    [uri]
    $DestinationSite
  )
  
  try 
  {
    Copy-AVPNPFile -SourceUrl $UriAspxFile -TargetPath $DestinationSite 
  }
  catch 
  {
    Write-Host $_
  }
  $SiteAssetsSourceURL = 
    ("{0}/{1}/{2}/{3}/{4}" -f $UriAspxFile.AbsoluteUri.Split("/")), 
    "/SiteAssets/SitePages/",
    $UriAspxFile.Segments[-1].Trim(".aspx") -join ""

  $SiteAssetsDestinationURL = 
    ("{0}/{1}/{2}/{3}/{4}" -f $DestinationSite.AbsoluteUri.Split("/")),
    "/SiteAssets/SitePages" -join ""
    
  Copy-AVPNPFile -SourceUrl $SiteAssetsSourceURL -TargetPath $SiteAssetsDestinationURL
}
