#!/usr/bin/env bash
set -euo pipefail

# Determine the venv Python path
VENV_PYTHON=".venv/bin/python"

# Check if venv exists
if [[ ! -f "$VENV_PYTHON" ]]; then
    echo "ERROR: Virtual environment not found at $VENV_PYTHON"
    echo "Create it with: python3 -m venv .venv"
    echo "Then install dependencies: .venv/bin/python -m pip install -r requirements-dev.txt"
    exit 1
fi

echo "== Python Interpreter =="
"$VENV_PYTHON" --version
echo

echo "== Ruff (lint) =="
"$VENV_PYTHON" -m ruff check . || exit 1
echo

echo "== Ruff (format check) =="
"$VENV_PYTHON" -m ruff format --check . || exit 1
echo

echo "== Pytest =="
"$VENV_PYTHON" -m pytest "$@"
