<#
Thanks to bcurran (https://github.com/bcurran3) and his awesome Chocolatey backup package, https://github.com/bcurran3/ChocolateyPackages/tree/master/choco-package-list-backup 
for inspiration.

This script gets a list of installed Chocolatey packages and creates a packages.config XML file in your Documents folder that can be used to install all packages.
To reinstall packages, run the following from the command line:
    choco install %homepath%\Documents\packages.config -y
This script also creates an HTML doc providing package details for easy reference.
#>
$PathOut = $env:HOMEPATH + "\Documents\packages.config"
$XmlSettings = New-Object System.Xml.XmlWriterSettings
$XmlSettings.Indent = $true
$XmlSettings.IndentChars = "    "
# get a .Net XmlWriter to create the XML
$XmlWriter = [System.XML.XmlWriter]::Create($PathOut, $XmlSettings)
$XmlWriter.WriteStartDocument()
$XmlWriter.WriteStartElement("packages")

# get list of installed packages with packageid only
# https://chocolatey.org/docs/commands-list
$PackageList = choco list -lo -y -r --idonly
$Nuspec = New-Object -TypeName XML

foreach($PackageId in $PackageList){
    # package install location info: https://chocolatey.org/docs/getting-started#how-does-chocolatey-work
    # nuspec file info: https://chocolatey.org/docs/create-packages#nuspec and https://docs.microsoft.com/en-us/nuget/reference/nuspec
    $Path = $env:ChocolateyInstall + "\lib\" + $PackageId + "\" + $PackageId + ".nuspec"
    $Nuspec.Load($Path)
    $XmlWriter.WriteStartElement("package")
    $XmlWriter.WriteAttributeString("id", $PackageId)
    $XmlWriter.WriteAttributeString("title", $Nuspec.package.metadata.title)
    $XmlWriter.WriteAttributeString("projecturl", $Nuspec.package.metadata.projecturl)
    $XmlWriter.WriteAttributeString("summary", $Nuspec.package.metadata.summary)
    $XmlWriter.WriteEndElement()
}
$XmlWriter.WriteEndElement()
$XmlWriter.WriteEndDocument()
$XmlWriter.Flush()
$XmlWriter.Close()

$PathXslt = "chocolatey-installed-package-report.xslt"
#$XsltSettings = New-Object System.Xml.Xsl.XsltSettings
#$XsltSettings.EnableDocumentFunction = $true
$Xslt = New-Object System.Xml.Xsl.XslCompiledTransform
$Xslt.Load($PathXslt)
$xslt.Transform($PathOut, "chocolatey.html")