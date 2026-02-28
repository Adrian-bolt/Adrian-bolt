<#
.SYNOPSIS
    Disabled WinRM Basic authentication on both the service and client to prevent the use of plaintext credentials during remote management sessions.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-27
    Last Modified   : 2026-02-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000345

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

# Create the WinRM Service policy registry path if it does not already exist
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Force | Out-Null

# Disable Basic authentication for the WinRM service to prevent plaintext credential use
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Name "AllowBasic" -PropertyType DWord -Value 0 -Force | Out-Null

# Create the WinRM Client policy registry path if it does not already exist
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -Force | Out-Null

# Disable Basic authentication for the WinRM client to enforce secure remote management
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -Name "AllowBasic" -PropertyType DWord -Value 0 -Force | Out-Null
