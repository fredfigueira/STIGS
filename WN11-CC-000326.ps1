<#
.SYNOPSIS
    Remediates DISA STIG WN11-CC-000326 - PowerShell Script Block Logging
    must be enabled.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000326
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000326/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Example syntax:
    PS C:\> .\WN11-CC-000326.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-CC-000326 - PowerShell Script Block Logging..." -ForegroundColor Yellow

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

try {
    New-Item -Path $regPath -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "EnableScriptBlockLogging" -PropertyType DWord -Value 1 -Force | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    Get-ItemProperty -Path $regPath -Name "EnableScriptBlockLogging"

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
