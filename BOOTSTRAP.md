# Bootstrap Guide for __PROJECT_NAME__

This document describes how to bootstrap the development environment for this project.

## Prerequisites

- Python 3.12 or higher (from python.org, not Microsoft Store)
- Git for Windows
- PowerShell 7 (recommended) or Windows PowerShell

## Quick Start

### 1. Clone and navigate to project
```powershell
cd C:\dev\projects
git clone <repository-url> <project-folder>
cd <project-folder>
```

### 2. Create and activate virtual environment
```powershell
# Create virtual environment
py -m venv .venv

# Activate it
.\.venv\Scripts\Activate.ps1

# Alternative (without activation): Always use .\.venv\Scripts\python.exe directly
```

### 3. Install development dependencies
```powershell
# Using requirements-dev.txt
python -m pip install -r requirements-dev.txt

# Or install individually
python -m pip install ruff pytest
```

### 4. Verify setup
```powershell
# Check Python environment
python -c "import sys; print(sys.executable)"

# Run linting
python -m ruff check .

# Run tests
python -m pytest tests/
```

## Development Workflow

### Quality Gate (always run before committing)
Use the project's quality gate script:
```powershell
.\scripts\check.ps1
```

For fixing linting issues:
```powershell
.\scripts\fix.ps1
```

### Cline Workflow (Punkt 11 & 12)
This project implements a structured Cline workflow:

1. **Branch per task**: `git checkout -b feature/<name>` or `fix/<name>`
2. **Baseline check**: Always run `.\scripts\check.ps1` before Cline work
3. **Plan Mode**: Create numbered plan (max 10 steps) with affected files
4. **Act Mode**: Implement one step at a time, run `.\scripts\check.ps1` after each
5. **Commit discipline**: Small, logical commits with clear messages (`feat:`, `fix:`, `test:`, `chore:`)
6. **PR preparation**: When green, create PR with motivation, changes, tests, risks

### Run specific tests
```powershell
# Run all tests
.\.venv\Scripts\python.exe -m pytest tests/

# Run specific test file
.\.venv\Scripts\python.exe -m pytest tests/test_smoke.py

# Run with verbose output
.\.venv\Scripts\python.exe -m pytest tests/ -v
```

## Project Structure

```
__PROJECT_NAME__/
├── .venv/                 # Python virtual environment (gitignored)
├── devproj/              # Main package
│   ├── __init__.py       # Package metadata
│   └── main.py           # Main module with add() and greet()
├── tests/                # Test suite
│   ├── test_greeting.py  # Tests for greeting functionality
│   └── test_smoke.py     # Smoke tests
├── pyproject.toml        # Central tool configuration
├── requirements.txt      # Runtime dependencies
├── requirements-dev.txt  # Development dependencies
├── README.md            # Project documentation
├── DEVELOPMENT.md       # Project Contract (Cline rules)
└── BOOTSTRAP.md        # This file
```

## Troubleshooting

### Python opens Microsoft Store
Disable App Execution Aliases:
1. Windows Settings → Apps → App Execution Aliases
2. Turn off `python.exe` and `python3.exe`

### PowerShell execution policy error
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Virtual environment not recognized
Always use explicit path:
```powershell
.\.venv\Scripts\python.exe -m pip --version
.\.venv\Scripts\python.exe -m pytest tests/
```

## Reproducibility

This setup ensures reproducible development:
1. **Isolated environment**: `.venv/` per project
2. **Version control**: All configuration in `pyproject.toml`
3. **Quality gates**: Consistent linting and testing
4. **Documentation**: Clear bootstrap process

The project is now ready for development with VS Code, Cline, or any other Python IDE.
