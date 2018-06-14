Import-Module $PSScriptRoot\SelectEnvironment.psm1

Select-Environment

$ApplicationListPath = Read-Host -Prompt 'Enter path where you want to copy the list of applications with version'
$ApplicationListPath = $ApplicationListPath +'\ApplicationList.csv'

if ($localOrRemote -eq "l")
{
    Connect-ServiceFabricCluster `
        -ConnectionEndpoint $connectionEndpoint
}
else
{
    Connect-ServiceFabricCluster `
    -ConnectionEndpoint $connectionEndpoint `
    -X509Credential `
    -StoreLocation 'CurrentUser' `
    -ServerCommonName $ServerCommonName `
    -FindType 'FindByThumbprint'   `
    -FindValue $Thumbprint 
}

 Get-ServiceFabricApplication | Select-Object ApplicationName,ApplicationTypeVersion | Export-Csv $ApplicationListPath -NoTypeInformation
