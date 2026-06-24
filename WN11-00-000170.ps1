<#
.SYNOPSIS
    Remediates DISA STIG WN11-00-000170 - The SMBv1 protocol must be
    disabled on the SMB client (the mrxsmb10 driver).

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000170
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-00-000170/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator. A restart is required for the driver change to
    fully take effect. Note: this control is marked Not Applicable if
    WN11-00-000160 (the SMB1Protocol optional feature) is already disabled,
    since that also removes the client-side functionality.
    Example syntax:
    PS C:\> .\WN11-00-000170.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-00-000170 - SMBv1 Client Driver (mrxsmb10)..." -ForegroundColor Yellow

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"

try {
    Set-ItemProperty -Path $regPath -Name "Start" -Value 4 -Type DWord -Force

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    Get-ItemProperty -Path $regPath -Name "Start"

    Write-Host "`nRemediation Complete. A reboot is required to fully apply this change." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
