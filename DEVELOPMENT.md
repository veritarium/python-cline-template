# Project Contract – Cline Arbeitsabkommen

Dieses Dokument definiert die Spielregeln für die Zusammenarbeit zwischen Entwickler und Cline. Es sorgt für klare Aufgaben, stabile Ergebnisse und verhindert typische Agent-Fehler.

## Definition of Done (DoD)

Eine Aufgabe ist "fertig", wenn:

- Das definierte Verhalten ist implementiert (Akzeptanzkriterien erfüllt).
- Das Quality Gate ist grün:
  - `ruff check .`
  - `ruff format --check .`
  - `python -m pytest`
- Neue/ändernde Logik hat Tests:
  - Feature: mind. 1 Test pro neuem Verhalten
  - Bugfix: Regression-Test, der vorher fehlschlägt
- Keine Neben-Refactors (nur Änderungen, die zur Aufgabe gehören).
- Keine neuen Dependencies ohne explizite Freigabe.
- Änderungen sind in kleinen, nachvollziehbaren Commits geschnitten.

## Quality Gate (immer ausführen)

- **Lint**:
  - `ruff check .`
- **Format**:
  - `ruff format --check .`
- **Tests**:
  - `python -m pytest`

**Warum `python -m pytest`**: Damit ist klar, dass pytest in der aktiven Python‑Umgebung läuft.

## Cline Scope & Safety

- **Standard**: Plan Mode zuerst. Act Mode erst nach Plan-Freigabe.
- **Cline darf nur im Workspace arbeiten** (keine Dateien außerhalb von `c:/dev/projects/Dev_Proj_Cline_Setup`).
- **Keine neuen Dependencies** ohne explizites OK von mir.
- **Keine Änderungen an Projekt-/Tooling-Konfig** (`pyproject.toml`, CI, pre-commit, etc.) ohne Nachfrage.
- **Keine Neben-Refactors**. Nur Änderungen, die zur Aufgabe gehören.
- **Terminal**: Kommandos nur ausführen, wenn ich sie freigebe.
- **Vor jedem Tool-Run**: sicherstellen, dass die `.venv` genutzt wird (sys.executable check, falls unklar).

## Arbeitsweise (Plan/Act)

### Plan Mode:
- Erstelle einen nummerierten Plan (max 10 Schritte).
- Jeder Schritt nennt: betroffene Dateien + Test/Check danach.

### Act Mode:
- Implementiere immer nur 1 Plan-Schritt pro Durchlauf (max 2, wenn ich es ausdrücklich sage).
- Nach jedem Schritt: kurz "Was wurde geändert?" + genau 1 Kommando fürs Quality Gate.
- Wenn Scope wächst: zurück in Plan Mode und Plan aktualisieren.

## Standard Nicht-Ziele (sofern nicht ausdrücklich verlangt)

- Keine Umbenennungen über das Feature hinaus
- Kein Formatieren/Lint-Fixing in unbeteiligten Dateien
- Keine Architektur-Umbauten "nebenbei"
- Keine neuen Libraries
- Keine Änderung von Public APIs ohne Rücksprache

## Prompt‑Templates

Diese drei reichen für 80 % der Arbeit.

### Plan Kickoff (Plan Mode):
```
Plan Mode.
Ziel: …
Akzeptanzkriterien: …
Nicht-Ziele: …
Bitte lies die relevanten Dateien und erstelle einen nummerierten Plan (max 10 Schritte).
Jeder Schritt: betroffene Dateien + Test/Check danach.
```

### Implementiere Schritt 1 (Act Mode):
```
Act Mode. Implementiere ausschließlich Schritt 1 aus dem Plan.
Keine Neben-Refactors, keine neuen Dependencies.
Danach: sag kurz, was geändert wurde, und nenne genau 1 Kommando für das Quality Gate.
```

### Debug Minimal (Act Mode):
```
Act Mode. Analysiere nur den Fehleroutput.
Schlage die kleinste Änderung vor, die den Fehler behebt.
Danach erneut Quality Gate (erst nach meiner Freigabe).
```

---

*Dieses Arbeitsabkommen gilt ab sofort für alle Interaktionen mit Cline in diesem Projekt.*
*Letzte Aktualisierung: $(date)*
