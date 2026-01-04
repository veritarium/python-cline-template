# python-cline-template

A Python project demonstrating proper setup with virtual environment, testing, and code quality tools.

## Use this template (recommended workflow)

### Linux (Ubuntu / code‑server) – Beispiel: KW01‑UBUNTU‑SYS

**Prerequisites**  
- `git`, `python3`, `python3‑venv`, `python3‑pip`  
- Optional: `pwsh` (PowerShell) für die PowerShell‑Skripte.

```bash
mkdir -p ~/dev/projects/info
cd ~/dev/projects
git clone https://github.com/veritarium/KW01-UBUNTU-SYS.git
cd KW01-UBUNTU-SYS

pwd
python3 --version
git --version
pwsh --version || true

sudo apt-get update
sudo apt-get install -y python3-venv python3-pip

ls -la scripts

pwsh ./scripts/bootstrap.ps1 -SetupVenv -NonInteractive

pwsh ./scripts/check.ps1

bash ./scripts/check.sh

git ls-files | grep -i "\.venv" || true

git status
git diff --name-only

git add -A
git commit -m "chore: bootstrap project"
git push
```

**Hinweise:**
- Falls `git commit` mit „Author identity unknown“ fehlschlägt, führe diese Befehle aus:  
  ```bash
  git config --global user.name "Dein Name"
  git config --global user.email "dein@mail.de"
  ```
- `bash ./scripts/check.sh` nur nutzen, wenn die Datei existiert (sie wird automatisch beim Bootstrap erstellt).

### Windows – Beispiel: KW01‑WINDOWS‑SYS

**Prerequisites**  
- `git`, `Python 3.12+` (über den Microsoft Store oder python.org)  
- PowerShell (bereits enthalten).

```powershell
cd C:\dev\projects
git clone https://github.com/veritarium/KW01-WINDOWS-SYS.git
cd KW01-WINDOWS-SYS

.\scripts\bootstrap.ps1 -SetupVenv -NonInteractive

#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#.\scripts\bootstrap.ps1 -SetupVenv -NonInteractive

.\scripts\check.ps1

git ls-files | findstr /I ".venv"

git status
git add -A
git commit -m "chore: bootstrap project"
git push -u origin main
```

**Hinweise:**
- Falls PowerShell‑Skripte blockiert sind, entferne das Kommentarzeichen vor `Set-ExecutionPolicy` und führe den Bootstrap erneut aus.
- Prüfe die CI auf GitHub unter **Actions** im neuen Repository.

**Standard option:** The Python package name stays `devproj`. Bootstrap adapts only project name, documentation, and memory bank.

For details see [TEMPLATE_USAGE.md](TEMPLATE_USAGE.md).

## Project Overview

This project serves as a template for Python development with modern tooling including:
- Virtual environment management
- Automated testing with pytest
- Code formatting and linting with ruff
- VS Code configuration for optimal development experience

## Features

- **Greeting Module**: A simple yet extensible greeting system
- **Comprehensive Testing**: Full test coverage with pytest
- **Code Quality**: Automated formatting and linting
- **Development Tools**: Pre-configured VS Code settings

## Getting Started

### Prerequisites

- Python 3.12 or higher
- Git (for version control)

### Installation

1. **Clone the repository** (if applicable):
   ```bash
   git clone <repository-url>
   cd <project-folder>
   ```

2. **Set up virtual environment**:
   ```bash
   python -m venv .venv
   ```

3. **Activate the virtual environment**:
   - **Windows**:
     ```bash
     .venv\Scripts\activate
     ```
   - **macOS/Linux**:
     ```bash
     source .venv/bin/activate
     ```

4. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

### Development Setup

The project includes VS Code configuration for optimal development:

- **Auto-activation** of virtual environment
- **Format on save** with ruff
- **Pytest integration** for testing
- **Code actions** for automatic fixes

## Usage

### Running the Main Script

```bash
python test_beispiel.py
```

This will execute the greeting program with default and custom examples.

### Running Tests

Run all tests:
```bash
pytest
```

Run tests with verbose output:
```bash
pytest -v
```

Run a specific test file:
```bash
pytest test_greeting.py
```

### Code Quality Checks

Format code with ruff:
```bash
ruff format .
```

Check for linting issues:
```bash
ruff check .
```

Fix auto-fixable issues:
```bash
ruff check --fix .
```

## Project Structure

```
python-cline-template/
├── .venv/                 # Python virtual environment (gitignored)
├── .vscode/              # VS Code configuration
│   └── settings.json    # Editor settings for Python development
├── test_beispiel.py     # Main Python module with greeting functionality
├── test_greeting.py     # Test suite for the greeting module
├── requirements.txt     # Project dependencies
├── .gitignore          # Git ignore rules for Python projects
└── README.md           # This file
```

## Code Examples

### Using the Greet Function

```python
from test_beispiel import greet

# Default greeting
result = greet()  # Greets "World" 10 times

# Custom greeting
result = greet("Alice", 5)  # Greets "Alice" 5 times
```

### Running the Main Program

```python
from test_beispiel import main

if __name__ == "__main__":
    main()
```

## Development Workflow

1. **Activate virtual environment** before starting work
2. **Write code** following Python best practices
3. **Run tests** to ensure functionality
4. **Format code** with ruff before committing
5. **Commit changes** with descriptive messages

## Dependencies

- **pytest**: Testing framework
- **ruff**: Code formatting and linting
- **colorama**: Cross-platform colored terminal text
- **packaging**: Core utilities for Python packages

See `requirements.txt` for complete list with versions.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add or update tests
5. Ensure all tests pass
6. Submit a pull request

## License

This project is available for use and modification. Please include attribution if redistributing.

## Acknowledgments

- Built with modern Python development practices
- Configured for optimal VS Code experience
- Includes comprehensive testing and code quality tools
