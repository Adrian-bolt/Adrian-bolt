<#
.SYNOPSIS
    Configured the SSL policy to prioritize stronger ECC curves by enforcing the order NistP384 followed by NistP256 to ensure more secure cryptographic negotiation.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-27
    Last Modified   : 2026-02-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000052

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

# Create the SSL policy registry path used to define ECC curve order
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" -Force | Out-Null

# Enforce STIG requirement by prioritizing stronger ECC curves (NistP384 first, then NistP256)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" -Name "EccCurves" -PropertyType MultiString -Value @("NistP384","NistP256") -Force | Out-Null
