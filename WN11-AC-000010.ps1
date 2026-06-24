<#
.SYNOPSIS
    Remediates DISA STIG WN11-AC-000010 - Account lockout threshold must be
    configured to 3 invalid logon attempts.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AC-000010/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Note: This also sets the companion lockout duration (WN11-AC-000005) and
    lockout observation window settings, since Windows requires all three to
    be configured together.
    Example syntax:
    PS C:\> .\WN11-AC-000010.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-AC-000010 - Account Lockout Threshold..." -ForegroundColor Yellow

try {
    net accounts /lockoutthreshold:3 | Out-Null
    net accounts /lockoutduration:15 | Out-Null
    net accounts /lockoutwindow:15   | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    net accounts | Select-String "Lockout"

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
