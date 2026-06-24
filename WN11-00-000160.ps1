<#
.SYNOPSIS
    Remediates DISA STIG WN11-00-000160 - The SMBv1 protocol must be
    disabled on the SMB server (and, by extension, the optional feature
    that backs the SMBv1 client as well).

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000160
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-00-000160/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator. A restart is required for the change to fully
    take effect.
    Example syntax:
    PS C:\> .\WN11-00-000160.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-00-000160 - SMBv1 Server..." -ForegroundColor Yellow

try {
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Select-Object FeatureName, State

    Write-Host "`nRemediation Complete. A reboot is required to fully apply this change." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
