<#
.SYNOPSIS
    Remediates DISA STIG WN11-CC-000345 - The Windows Remote Management
    (WinRM) service must not use Basic authentication.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000345
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000345/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Example syntax:
    PS C:\> .\WN11-CC-000345.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-CC-000345 - WinRM Service Basic Authentication..." -ForegroundColor Yellow

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"

try {
    New-Item -Path $regPath -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "AllowBasic" -PropertyType DWord -Value 0 -Force | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    Get-ItemProperty -Path $regPath -Name "AllowBasic"

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
