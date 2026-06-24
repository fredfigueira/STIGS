<#
.SYNOPSIS
    Remediates DISA STIG WN11-AC-000040 - The built-in Microsoft password
    complexity filter must be enabled.

.NOTES
    Author          : Alfred Figueira
    LinkedIn        : https://www.linkedin.com/in/alfred-figueira-/
    GitHub          : https://github.com/fredfigueira/
    Date Created    : 2026-06-24
    Last Modified   : 2026-06-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000040
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AC-000040/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run as Administrator.
    Note: Password complexity has no dedicated PowerShell cmdlet, so this
    script edits the local security policy via secedit, which is the
    scriptable equivalent of toggling the setting in secpol.msc.
    Example syntax:
    PS C:\> .\WN11-AC-000040.ps1
#>

#Requires -RunAsAdministrator

Write-Host "Remediating WN11-AC-000040 - Password Complexity..." -ForegroundColor Yellow

$exportPath = "$env:TEMP\secpol_WN11-AC-000040.cfg"
$dbPath     = "$env:TEMP\secedit_WN11-AC-000040.sdb"

try {
    # Export current local security policy
    secedit /export /cfg $exportPath /quiet | Out-Null

    # Force PasswordComplexity = 1 (Enabled)
    (Get-Content $exportPath) -replace 'PasswordComplexity\s*=\s*0', 'PasswordComplexity = 1' |
        Set-Content $exportPath

    # Re-import the modified policy
    secedit /configure /db $dbPath /cfg $exportPath /areas SECURITYPOLICY /quiet | Out-Null

    Write-Host "`nValidation Results:" -ForegroundColor Cyan
    secedit /export /cfg $exportPath /quiet | Out-Null
    Select-String -Path $exportPath -Pattern "PasswordComplexity"

    Write-Host "`nRemediation Complete." -ForegroundColor Green
}
catch {
    Write-Host "`nRemediation FAILED: $_" -ForegroundColor Red
    exit 1
}
finally {
    Remove-Item $exportPath, $dbPath -ErrorAction SilentlyContinue
}
