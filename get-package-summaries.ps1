<#
1. Get list of packages
2. For each package get C:\ProgramData\chocolatey\lib\<package.id>\<package.id>.nuspec file
3. Get package\metadata\summary
4. Append summary as package attribute in C:\Users\John\Documents\Code\chocolatey\packages.config
5. (or maybe make HTML)

#>
$Path = "C:\Users\John\Documents\Code\chocolatey\packages.config"
# load it into an XML object:
#$packages = New-Object -TypeName XML
#$packages.Load($Path)

# using Get-Content seems to clean up bad XML...
[XML]$packages = Get-Content $Path
$packages.packages.package[1]
