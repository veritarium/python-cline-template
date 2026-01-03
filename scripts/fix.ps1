# scripts/fix.ps1
# Wendet Ruff-Fixes an und formatiert den Code.
# Empfehlung: vorher git status clean oder einen Commit/Checkpoint haben.

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$VenvPython = Join-Path $RepoRoot ".venv\Scripts\python.exe"
$VenvRuff   = Join-Path $RepoRoot ".venv\Scripts\ruff.exe"

function Assert-FileExists([string]$Path, [string]$Hint) {
    if (-not (Test-Path $Path)) {
        Write-Host "Fehlt: $Path"
        Write-Host $Hint
        exit 1
    }
}

function Run-Step([string]$Title, [string]$Exe, [string[]]$Arguments) {
    Write-Host ""
    Write-Host "== $Title =="
    & $Exe @Arguments
    $code = $LASTEXITCODE
    if ($code -ne 0) {
        Write-Host ""
        Write-Host "FEHLER in Schritt: $Title (Exit Code $code)"
        exit $code
    }
}

Assert-FileExists $VenvPython "Erstelle die venv im Repo-Root:  py -m venv .venv"
Assert-FileExists $VenvRuff   "Installiere ruff in der venv:      .\.venv\Scripts\python.exe -m pip install -U ruff"

Run-Step "Ruff (lint + fix)" $VenvRuff @("check", ".", "--fix")
Run-Step "Ruff (format)"     $VenvRuff @("format", ".")

# Optional: danach direkt testen (empfohlen)
Run-Step "Pytest" $VenvPython @("-m", "pytest")
