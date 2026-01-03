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
   - Replace `__PROJECT_NAME__` in text files with your project name
   - Create `.venv` (if it doesn't exist)
   - Install development tools (ruff, pytest)
   - Run the quality gate (`.\scripts\check.ps1`)

3) **Verify** everything works:
   ```powershell
   .\scripts\check.ps1
   ```

4) **Commit** the bootstrap changes:
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
