<#
1. Get list of packages
2. For each package get C:\ProgramData\chocolatey\lib\<package.id>\<package.id>.nuspec file
3. Get package\metadata\summary
4. Append summary as package attribute in C:\Users\John\Documents\Code\chocolatey\packages.config
5. (or maybe make HTML)

#>
$PathOut = "C:\Users\John\Documents\Code\chocolatey\packages-test.config"
# get an XMLTextWriter to create the XML
$XmlWriter = New-Object System.Xml.XmlTextWriter($PathOut,$Null)
$XmlWriter.Formatting = 'Indented'
$XmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
$XmlWriter.WriteStartDocument()
$XmlWriter.WriteStartElement("packages")

# load it into an XML object:
#$packages = New-Object -TypeName XML
#$packages.Load($Path)
#choco.exe list 
$packagelist = choco.exe list -lo -y -r --idonly
# using Get-Content seems to clean up bad XML...
#[XML]$packages = Get-Content $Path
#$packages.packages.package[1]
foreach($packageid in $packagelist)
{
    $path = "C:\ProgramData\chocolatey\lib\" + $packageid + "\" + $packageid + ".nuspec"
    [XML]$nuspec = Get-Content $Path
    $summary = $nuspec.package.metadata.title
    $XmlWriter.WriteStartElement("package")
    $XmlWriter.WriteAttributeString("id", $packageid)
    $XmlWriter.WriteAttributeString("summary", $summary)
    $XmlWriter.WriteEndElement()
}
$XmlWriter.WriteEndElement()
$XmlWriter.WriteEndDocument()
$XmlWriter.Flush()
$XmlWriter.Close()
