# scripts/check.ps1
# Quality Gate: Ruff lint + Ruff format check + pytest
# Läuft robust, auch wenn keine venv aktiviert ist.

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
# pytest wird über python -m pytest gestartet, daher kein eigener exe-check nötig.

# 0) Interpreter-Check (hilft enorm bei Debugging)
Run-Step "Python Interpreter" $VenvPython @("-c", "import sys; print(sys.executable)")

# 1) Lint
Run-Step "Ruff (lint)" $VenvRuff @("check", ".")

# 2) Format-Check (bricht ab, wenn Formatierung nicht passt)
Run-Step "Ruff (format check)" $VenvRuff @("format", "--check", ".")

# 3) Tests
Run-Step "Pytest" $VenvPython @("-m", "pytest")
