<#
.SYNOPSIS
    Disabled indexing of encrypted files by enforcing the required Windows Search policy registry setting to ensure encrypted data is not included in system indexing.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-26
    Last Modified   : 2026-02-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000305

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Configure the Windows Search policy path to enforce STIG-compliant indexing settings
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name "AllowIndexingEncryptedStoresOrItems" -PropertyType DWord -Value 0 -Force | Out-Null

# Force Group Policy to apply the new configuration immediately
gpupdate /force | Out-Null

# Verify that indexing of encrypted files is disabled (value should return 0)
Get-ItemProperty -Path $regPath -Name "AllowIndexingEncryptedStoresOrItems"
