# scripts/fix.ps1
# Wendet Ruff-Fixes an und formatiert den Code.
# Empfehlung: vorher git status clean oder einen Commit/Checkpoint haben.

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot

if ($IsWindows) {
    $VenvPython = Join-Path $RepoRoot ".venv\Scripts\python.exe"
    $VenvHint   = "Erstelle die venv im Repo-Root:  py -m venv .venv"
} else {
    # Linux / macOS
    $VenvPython = Join-Path $RepoRoot ".venv/bin/python"
    $VenvHint   = "Erstelle die venv im Repo-Root:  python3 -m venv .venv"
}

# $VenvRuff wird nicht mehr benötigt, da ruff über python -m ruff läuft.

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

Assert-FileExists $VenvPython $VenvHint

Run-Step "Ruff (lint + fix)" $VenvPython @("-m", "ruff", "check", ".", "--fix")
Run-Step "Ruff (format)"     $VenvPython @("-m", "ruff", "format", ".")

# Optional: danach direkt testen (empfohlen)
Run-Step "Pytest" $VenvPython @("-m", "pytest")
