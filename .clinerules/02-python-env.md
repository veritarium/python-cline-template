# Python Environment (Windows)

- Assume Windows + PowerShell.
- Never edit anything inside .venv/ and never read ignored files.
- Use the project venv executables explicitly when running commands:
  - .\.venv\Scripts\python.exe
  - .\.venv\Scripts\ruff.exe
- Preferred quality gate command:
  - .\scripts\check.ps1
- If interpreter confusion occurs, first run:
  - .\.venv\Scripts\python.exe -c "import sys; print(sys.executable)"
