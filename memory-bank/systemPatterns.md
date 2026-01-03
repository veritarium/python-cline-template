# System Patterns
- Repo layout: Standard Python package with devproj/ module, tests/, scripts/
- Where core logic lives: devproj/main.py
- Where IO/CLI lives: devproj/main.py (greet command)
- Error handling conventions: Standard Python exceptions, pytest for testing
- Public APIs that must not break: greet function in devproj.main
