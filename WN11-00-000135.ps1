<#
.SYNOPSIS
    Remediates DISA STIG WN11-00-000135 - Windows Defender Firewall must be enabled
    for the Domain, Private, and Public profiles.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000135
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-00-000135/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Example syntax:
    PS C:\> .\WN11-00-000135.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-00-000135 - Windows Defender Firewall..." -ForegroundColor Yellow

try {
    # Enable Windows Defender Firewall for all three profiles
    Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    Get-NetFirewallProfile | Select-Object Name, Enabled | Format-Table -AutoSize

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
