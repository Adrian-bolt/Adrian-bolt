<#
.SYNOPSIS
    Enabled the fPromptForPassword policy to require users to enter credentials for every Remote Desktop connection, preventing the use of saved passwords.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-27
    Last Modified   : 2026-02-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000280

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

# Create the Terminal Services policy registry path if it does not already exist
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Force | Out-Null

# Enforce the STIG setting to always prompt for a password during Remote Desktop connections
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "fPromptForPassword" -PropertyType DWord -Value 1 -Force | Out-Null
