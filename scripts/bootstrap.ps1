# scripts/bootstrap.ps1
# Bootstrap script for __PROJECT_NAME__ template.
# Replaces __PROJECT_NAME__ placeholder in text files and optionally sets up venv.
# Usage:
#   .\scripts\bootstrap.ps1 [-SetupVenv] [-NonInteractive] [-ProjectName <name>]
#   -SetupVenv: create .venv, install tools, run check.ps1
#   -NonInteractive: skip confirmation prompts
#   -ProjectName: override default (folder name)

param(
    [switch]$SetupVenv,
    [switch]$NonInteractive,
    [string]$ProjectName
)

$ErrorActionPreference = "Stop"

# --- OS detection and platform-specific paths ---
if ($IsWindows) {
    $VenvPython = ".venv\Scripts\python.exe"
    # Check if py is available, otherwise use python
    if (Get-Command "py" -ErrorAction SilentlyContinue) {
        $VenvCommand = "py"
    } else {
        $VenvCommand = "python"
    }
} else {
    # Linux / macOS
    $VenvPython = ".venv/bin/python"
    if (Get-Command "python3" -ErrorAction SilentlyContinue) {
        $VenvCommand = "python3"
    } else {
        $VenvCommand = "python"
    }
}

$CheckCommand = if ($IsWindows) { ".\scripts\check.ps1" } else { "pwsh ./scripts\check.ps1" }

# --- Helper functions ---
function Write-Info([string]$Message) {
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Success([string]$Message) {
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Warning([string]$Message) {
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Write-Error([string]$Message) {
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Confirm-Continue([string]$Message) {
    if ($NonInteractive) { return $true }
    Write-Host "$Message (Y/N)" -ForegroundColor Yellow -NoNewline
    $response = Read-Host
    return ($response -eq 'Y' -or $response -eq 'y')
}

# --- Determine project name ---
if (-not $ProjectName) {
    $ProjectName = Split-Path (Get-Location) -Leaf
    Write-Info "Using folder name as project name: $ProjectName"
} else {
    Write-Info "Using provided project name: $ProjectName"
}

# --- Validate project name ---
if ($ProjectName -match '[<>:"/\\|?*]') {
    Write-Error "Invalid project name: contains illegal characters"
    exit 1
}

# --- Text file extensions to process ---
$TextExtensions = @('.md', '.txt', '.toml', '.json', '.yml', '.yaml')
# Note: .ps1 removed to avoid modifying script files

# --- Directories to ignore ---
$IgnoreDirs = @('.git', '.venv', '__pycache__', '.pytest_cache', '.ruff_cache', '.mypy_cache', '.pyright', 'build', 'dist', 'scripts')

# --- Step 1: Replace __PROJECT_NAME__ in text files ---
Write-Info "Step 1: Replacing __PROJECT_NAME__ with '$ProjectName' in text files"

$filesChanged = @()
Get-ChildItem -Recurse -File | Where-Object {
    $ext = $_.Extension.ToLower()
    $dir = $_.DirectoryName
    $shouldProcess = $TextExtensions -contains $ext -and
                     -not ($IgnoreDirs | Where-Object { $dir -match $_ }) -and
                     -not ($_.Name -like 'requirements*.txt')
    return $shouldProcess
} | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match '__PROJECT_NAME__') {
        $newContent = $content -replace '__PROJECT_NAME__', $ProjectName
        Set-Content -Path $_.FullName -Value $newContent -NoNewline
        $filesChanged += $_.FullName
        Write-Info "  Updated: $($_.Name)"
    }
}

if ($filesChanged.Count -eq 0) {
    Write-Info "No files needed __PROJECT_NAME__ replacement."
} else {
    Write-Success "Updated $($filesChanged.Count) file(s)."
}

# --- Step 2: Optional venv setup ---
if ($SetupVenv) {
    Write-Info "Step 2: Setting up virtual environment and tools"
    
    # Check if .venv already exists
    if (Test-Path ".venv") {
        Write-Warning ".venv already exists. Skipping creation."
    } else {
        if (-not (Confirm-Continue "Create .venv and install tools?")) {
            Write-Info "Skipping venv setup."
            exit 0
        }
        
        Write-Info "Creating .venv..."
        & $VenvCommand -m venv .venv
        if (-not $?) {
            Write-Error "Failed to create .venv"
            exit 1
        }
    }
    
    # Ensure we use the venv Python (path is OS‑dependent)
    if (-not (Test-Path $VenvPython)) {
        Write-Error "$VenvPython not found"
        exit 1
    }
    
    Write-Info "Updating pip..."
    & $VenvPython -m pip install -U pip setuptools wheel
    if (-not $?) {
        Write-Error "Failed to update pip"
        exit 1
    }
    
    # Install dependencies
    if (Test-Path "requirements-dev.txt") {
        Write-Info "Installing from requirements-dev.txt..."
        & $VenvPython -m pip install -r requirements-dev.txt
    } else {
        Write-Info "Installing ruff and pytest..."
        & $VenvPython -m pip install -U ruff pytest
    }
    
    if (-not $?) {
        Write-Error "Failed to install dependencies"
        exit 1
    }
    
    # Run quality gate
    Write-Info "Running quality gate..."
    & .\scripts\check.ps1
    if (-not $?) {
        Write-Error "Quality gate failed. Please check output above."
        exit 1
    }
    
    Write-Success "Venv setup completed and quality gate passed."
}

# --- Final output ---
Write-Host ""
Write-Host "=" * 60
Write-Host "BOOTSTRAP COMPLETE" -ForegroundColor Green
Write-Host "=" * 60
Write-Host ""
Write-Host "Project name set to: $ProjectName"
if ($filesChanged.Count -gt 0) {
    Write-Host "Files updated: $($filesChanged.Count)"
}
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Review changes: git diff"
Write-Host "2. Commit bootstrap changes:"
Write-Host "   git add -A"
Write-Host "   git commit -m 'chore: bootstrap project'"
Write-Host ""
if (-not $SetupVenv) {
    Write-Host "To set up virtual environment and tools, run:"
    Write-Host "   .\scripts\bootstrap.ps1 -SetupVenv"
}
Write-Host "To verify everything works:"
Write-Host "   $CheckCommand"
Write-Host ""
