<#
.SYNOPSIS
    Remediates DISA STIG WN11-AC-000035 - Minimum password length must be
    configured to 14 characters.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000035
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AC-000035/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Example syntax:
    PS C:\> .\WN11-AC-000035.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-AC-000035 - Minimum Password Length..." -ForegroundColor Yellow

try {
    net accounts /minpwlen:14 | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    net accounts | Select-String "Minimum password length"

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
