<#
.SYNOPSIS
     Configured the system to disable AutoRun and AutoPlay on all drive types by enforcing the required registry policy settings to meet STIG compliance.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-28
    Last Modified   : 2026-02-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000185

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

# Disable AutoRun for all drive types using the enforced Group Policy registry path
$polPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
New-Item -Path $polPath -Force | Out-Null
New-ItemProperty -Path $polPath -Name "NoDriveTypeAutoRun" -PropertyType DWord -Value 255 -Force | Out-Null
New-ItemProperty -Path $polPath -Name "NoAutorun" -PropertyType DWord -Value 1 -Force | Out-Null

# Disable AutoRun for all drive types using the legacy CurrentVersion registry path (some audits check this location)
$cvPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
New-Item -Path $cvPath -Force | Out-Null
New-ItemProperty -Path $cvPath -Name "NoDriveTypeAutoRun" -PropertyType DWord -Value 255 -Force | Out-Null
New-ItemProperty -Path $cvPath -Name "NoAutorun" -PropertyType DWord -Value 1 -Force | Out-Null

# Force Group Policy to apply the changes immediately
gpupdate /force
