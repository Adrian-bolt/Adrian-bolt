<#
.SYNOPSIS
     Disables HTTP-based printing in Windows 11 to prevent unencrypted print traffic and meet STIG compliance.
     
.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-26
    Last Modified   : 2026-02-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110 

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

# Define the registry path where the printing policy is stored.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"


# Ensure the registry key exists so the policy value can be written.
if (-not (Test-Path $regPath)) { 
    New-Item -Path $regPath -Force | Out-Null 
}


# Enable the "Turn off printing over HTTP" policy.
# Setting this value to 1 disables HTTP-based printing.
New-ItemProperty -Path $regPath -Name "DisableHTTPPrinting" -PropertyType DWord -Value 1 -Force | Out-Null


# Refresh Group Policy to apply the configuration immediately.
gpupdate /force | Out-Null


# Verify the policy was successfully configured.
Get-ItemProperty -Path $regPath -Name "DisableHTTPPrinting"
