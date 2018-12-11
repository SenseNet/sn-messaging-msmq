$srcPath = [System.IO.Path]::GetFullPath(($PSScriptRoot + '\..\..\src'))

# delete existing packages
Remove-Item $PSScriptRoot\*.nupkg

nuget pack $srcPath\SenseNet.Messaging.MSMQ\SenseNet.Messaging.MSMQ.nuspec -properties Configuration=Release -OutputDirectory $PSScriptRoot