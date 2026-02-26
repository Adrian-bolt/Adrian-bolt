<#
.SYNOPSIS
    This PowerShell script disables the Windows Installer "AlwaysInstallElevated" setting by enforcing the required registry values to comply with STIG WN11-CC-000315.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-26
    Last Modified   : 2026-02-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

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


# Define the registry paths where the policy can exist
$paths = @(
  "HKLM:\Software\Policies\Microsoft\Windows\Installer",  # Machine-wide policy
  "HKCU:\Software\Policies\Microsoft\Windows\Installer"   # Current user policy
)

# Loop through each registry path
foreach ($p in $paths) {

  # If the registry path does not exist, create it
  if (-not (Test-Path $p)) {
      New-Item -Path $p -Force | Out-Null
  }

  # Set the "AlwaysInstallElevated" value to 0 (Disabled)
  # PropertyType DWord ensures correct data type
  New-ItemProperty -Path $p `
                   -Name "AlwaysInstallElevated" `
                   -PropertyType DWord `
                   -Value 0 `
                   -Force | Out-Null
}

# Verify the registry values after setting them
$hklm = Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Installer" `
                         -Name "AlwaysInstallElevated" `
                         -ErrorAction SilentlyContinue

$hkcu = Get-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Installer" `
                         -Name "AlwaysInstallElevated" `
                         -ErrorAction SilentlyContinue

# Output verification results
Write-Output "HKLM AlwaysInstallElevated = $($hklm.AlwaysInstallElevated)"
Write-Output "HKCU AlwaysInstallElevated = $($hkcu.AlwaysInstallElevated)"

# Force a Group Policy refresh to apply changes immediately
gpupdate /force | Out-Null
