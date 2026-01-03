# Tech Context (Windows)

- OS: Windows, shell: PowerShell
- Python: 3.12
- Venv: .venv/ in repo root
- Quality gate:
  - .\scripts\check.ps1
- Key commands:
  - .\.venv\Scripts\python.exe -m pip install -U ruff pytest
- Testing:
  - pytest, tests in /tests
- Lint/format:
  - Ruff configured in pyproject.toml

## Troubleshooting Ladder (Windows/Cline/Python)

### Stufe 1: Harte Fakten sammeln (2 Minuten)
Im Repo‑Root:
- `git status`
- `.\.venv\Scripts\python.exe -c "import sys; print(sys.executable)"`
- `.\.venv\Scripts\python.exe -m pip --version`
- `.\scripts\check.ps1`

### Stufe 2: „Falsche venv / falsches Python“ (häufigster Fehler)
Symptome: pytest findet Pakete nicht, ruff wird nicht gefunden, Verhalten ist „anders als gestern“
Fix‑Prinzip:
- Nutze konsequent venv‑Executables: `.\.venv\Scripts\python.exe …`, `.\.venv\Scripts\ruff.exe …`
- In VS Code: Interpreter neu wählen (Python: Select Interpreter) und .venv setzen

### Stufe 3: Cline kann Terminal‑Output nicht lesen / hängt
Symptome: Cline wartet ewig auf Output, Commands laufen, aber Cline „sieht“ das Ergebnis nicht
Fix‑Schritte:
- VS Code neu starten
- In Cline Settings: Terminal Execution Mode auf Background Exec
- Keine Inline‑Kommandos mit komplexem Quoting verwenden
- Stattdessen Skripte ausführen (.\scripts\check.ps1), oder ein temporäres .py Script statt python -c "..."

### Stufe 4: Quoting‑Probleme (Windows‑Kante)
Symptome: python -c "..." oder ähnliche Befehle brechen nur unter Cline/Background Exec
Stabiler Workaround:
- Schreib Diagnosen in eine Datei: scripts/diag.py und dann `.\.venv\Scripts\python.exe scripts\diag.py`
- Halte Cline‑Commands „quote‑arm“: Lieber `.\scripts\check.ps1` als lange, gequotete Einzeiler

### Stufe 5: Performance / „Cline wird unpräzise“
Symptome: Cline liest zu viel, Antworten werden unsauber, Scope driftet
Fix‑Prinzip:
- .clineignore erweitern (Caches, Builds, Datenfiles, Logs)
- Aufgaben kleiner schneiden (max 1–3 Dateien pro Iteration)
- Neuen Task starten und Status in memory-bank/activeContext.md / progress.md festhalten

### Diagnose‑Prompt (Copy/Paste für Cline)
```
Plan Mode. Diagnose unter Windows.
Ziel: herausfinden, warum Tool‑Runs/venv/Terminal nicht korrekt funktionieren.
Nenne die 3 wichtigsten Checks, die du als erstes machen willst.
Gehe davon aus, dass die Wahrheit .\scripts\check.ps1 ist.
Wenn du Commands vorschlägst: nutze ausschließlich .venv\\Scripts\\python.exe und .\scripts\check.ps1.
Erstelle danach einen Fix‑Plan in max 6 Schritten. Keine Codeänderungen.
```
