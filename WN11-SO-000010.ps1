<#
.SYNOPSIS
    Remediates DISA STIG WN11-SO-000010 - The built-in Guest account must
    be disabled.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000010
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-SO-000010/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Example syntax:
    PS C:\> .\WN11-SO-000010.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-SO-000010 - Guest Account..." -ForegroundColor Yellow

try {
    net user Guest /active:no | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    net user Guest | Select-String "Account active"

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
