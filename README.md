# Introduction
Files I use with Chocolatey.

https://chocolatey.org/

# Roadmap
- Script to show dependencies (as shown in .nuspec).

# get-chocolatey-installed-packages.ps1

Thanks to bcurran (https://github.com/bcurran3) and his awesome Chocolatey backup package, https://github.com/bcurran3/ChocolateyPackages/tree/master/choco-package-list-backup for inspiration.

This script gets a list of installed Chocolatey packages and creates a packages.config XML file in your Documents folder that can be used to install all packages.

## Using
Place both these files in the same directory and run the Powershell script:

- get-chocolatey-installed-packages.ps1
- chocolatey-installed-package-report.xslt

To reinstall all packages listed in the packages.config file, run the following from the command line:
    `choco install packages.config -y`

This script also creates an HTML doc providing package details for easy reference.

Both files are created in the same directory where the script is run.
