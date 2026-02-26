<#
.SYNOPSIS
     Configures Windows 11 to send only the minimum diagnostic data required for STIG compliance.
     
.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-26
    Last Modified   : 2026-02-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000204 

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

# Define the registry path where the telemetry policy is stored.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"


# Ensure the registry path exists so the policy value can be written.
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}


# Configure the AllowTelemetry value (1 = Required/Basic, 0 = Security-only).
New-ItemProperty -Path $regPath -Name "AllowTelemetry" -PropertyType DWord -Value 1 -Force | Out-Null


# Apply the updated policy immediately.
gpupdate /force


# Verify the telemetry configuration was set successfully.
Get-ItemProperty -Path $regPath -Name "AllowTelemetry"
