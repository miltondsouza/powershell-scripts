<#
.SYNOPSIS
    This script performs a complete removal of Citrix Workspace from the system, regardless of the installed version.

.DESCRIPTION
    The script is designed to act as a cleanup tool for uninstalling Citrix Workspace in any version that might be installed on the system.
    
.NOTES
    Version: 1.0
    Author: Milton Dsouza
    Date: 30th Sep 2024
#>

function Get-UninstallString  {
    param(
        [String]$ApplicationName
    )

    $uninstallStrings = @()

    # Define registry paths for 32-bit and 64-bit Uninstall entries
    $regPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",      # 64-bit
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" # 32-bit
    )

    # Loop through registry paths to find Citrix Workspace
    foreach ($path in $regPaths) {
        $apps = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue
        foreach ($app in $apps) {
            if ($app.DisplayName -like "*$ApplicationName*") {
                $uninstallStrings += $app.UninstallString
            }
        }
    }

    # Return Uninstall Strings
    return $uninstallStrings
}

