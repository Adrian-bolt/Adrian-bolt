<#
.SYNOPSIS
    Disabled Microsoft Consumer Experiences by enforcing the DisableWindowsConsumerFeatures registry policy to prevent consumer content and suggested apps on Windows 11.

.NOTES
    Author          : Adrian Bolt
    LinkedIn        : linkedin.com/in/adrianbolt/
    GitHub          : github.com/Adrian-bolt
    Date Created    : 2026-02-27
    Last Modified   : 2026-02-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197

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

# Create the policy registry path for Windows Cloud Content settings
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null

# Enforce STIG setting to disable Microsoft Consumer Experiences (Policy location)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWord -Value 1 -Force | Out-Null

# Create the CurrentVersion registry path for Cloud Content (build compatibility support)
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudContent" -Force | Out-Null

# Set the same value in CurrentVersion path to ensure compliance detection passes
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWord -Value 1 -Force | Out-Null
