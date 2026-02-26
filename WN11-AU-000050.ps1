<#
.SYNOPSIS
    Enables Detailed Tracking > Process Creation (Success) to remediate STIG WN11-AU-000050.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-26
    Last Modified   : 2026-02-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000050

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

# Force Advanced Audit Policy subcategories to override legacy audit policy (recommended for STIG consistency)
New-ItemProperty `
  -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" `
  -Name "SCENoApplyLegacyAuditPolicy" `
  -PropertyType DWord `
  -Value 1 `
  -Force | Out-Null

# Enable Detailed Tracking -> Process Creation (Success + Failure is allowed; Success is required)
auditpol.exe /set /subcategory:"Process Creation" /success:enable /failure:enable | Out-Null

# Refresh policy
gpupdate.exe /force | Out-Null

# Verify (should show Success enabled for Process Creation)
auditpol.exe /get /subcategory:"Process Creation"
