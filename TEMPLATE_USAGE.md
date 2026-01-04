# Template Usage

This repository is a template for Python + VS Code + Cline on Windows.

## Standard option (recommended start)

- The Python package name stays `devproj`.
- Bootstrap adapts only project name / docs / memory.

## Steps after creating a repo from this template and cloning it

1) **Clone** the new repository:
   ```powershell
   git clone <repository-url>
   cd <project-folder>
   ```

2) **Bootstrap** the project:
   ```powershell
   .\scripts\bootstrap.ps1 -SetupVenv
   ```
   This will:
   - Replace `python-cline-template` in text files with your project name
   - Create `.venv` (if it doesn't exist)
   - Install development tools (ruff, pytest)
   - Run the quality gate (`.\scripts\check.ps1`)

3) **VS Code / code‑server Setup**

   After bootstrapping, select the correct Python interpreter in VS Code:

   1. Open the command palette (Ctrl+Shift+P / Cmd+Shift+P).
   2. Type "Python: Select Interpreter" and select the command.
   3. Choose the interpreter from the `.venv` folder:
      - **Windows**: `./.venv/Scripts/python.exe`
      - **Linux/macOS**: `./.venv/bin/python`

   Once selected, VS Code will use the virtual environment for IntelliSense, linting, testing, and formatting.

### Linux / code‑server notes

- **PowerShell scripts:** On Linux, prefix the script calls with `pwsh` (e.g., `pwsh ./scripts/bootstrap.ps1`).  
  If pwsh is not installed, you can install it via `sudo apt‑get install -y powershell` or use the Bash fallback `scripts/check.sh`.

- **Virtual environment paths:** The Python interpreter inside the virtual environment is located at `.venv/bin/python` (instead of `.venv\Scripts\python.exe` on Windows).

- **Missing python3‑venv:** If `python3 -m venv .venv` fails, install the system package:
  ```bash
  sudo apt‑get install -y python3‑venv
  ```

- **Bash fallback:** A Bash version of the quality‑gate script is available as `scripts/check.sh`. It can be used on systems without PowerShell.

4) **Verify** everything works:
   ```powershell
   .\scripts\check.ps1
   ```

5) **Commit** the bootstrap changes:
   ```powershell
   git add -A
   git commit -m "chore: bootstrap project"
   ```

## For documentation-only updates (no venv)

If you only want to update project name in documentation:
```powershell
.\scripts\bootstrap.ps1
```

## What stays unchanged

- Python package name: `devproj`
- Core project structure
- Quality gate (`.\scripts\check.ps1`)
- GitHub Actions CI (if enabled)

## Next steps

After bootstrap:
- Review the changes: `git diff`
- Start development with Cline workflow (see `DEVELOPMENT.md`)
- Run `.\scripts\check.ps1` before each commit

## Template maintenance

This template is maintained at: `python-cline-template`
For updates, see `CHANGELOG.md` (if available).
