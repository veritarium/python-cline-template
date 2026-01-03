# Workflow (Plan/Act)

## Core Principles
- Always start in Plan Mode for tasks touching more than 1 file.
- In Plan Mode: produce a numbered plan (max 10 steps).
  Each step must list affected files and the check to run afterwards.
- In Act Mode: implement only ONE plan step per iteration unless I explicitly allow more.
- No scope creep: if new work is discovered, return to Plan Mode and update the plan.

## Real-Repository Workflow (Punkt 12)
### Branch & Baseline
1. **Branch per task**: `git checkout -b feature/<name>` or `fix/<name>`
2. **Baseline check**: Always run `.\scripts\check.ps1` before Cline work
3. **If baseline red**: Fix baseline first (don't debug "wrong causes")

### Plan Mode Template
```
Plan Mode.
Ziel: …
Akzeptanzkriterien: …
Nicht‑Ziele: …
Lies nur die relevanten Dateien (ich verlinke sie) und erstelle einen Plan (max 10 Schritte).
Jeder Schritt: betroffene Dateien + danach .\scripts\check.ps1.
Keine Änderungen.
```

### Act Mode Template
```
Act Mode. Implementiere ausschließlich Schritt 1 aus dem Plan.
Keine Neben‑Refactors, keine neuen Dependencies.
Danach: führe .\scripts\check.ps1 aus (erst nach meiner Freigabe).
```

### Commit Discipline
- **One logical change per commit**: "Core function + tests", "CLI flag + tests"
- **If Cline produces large diff**: Roll back, redo in smaller steps
- **No "whole repo reformatting"** in feature commits
- **Commit message schema**: `feat(core): ...`, `fix(cli): ...`, `test: ...`, `chore: ...`

### PR Preparation
- **When green**: Create PR with motivation, changes, tests, risks
- **Review checklist**:
  1. Behavior matches acceptance criteria
  2. Tests are meaningful (would fail if broken)
  3. Scope maintained (no "side work")
  4. `.\scripts\check.ps1` is green
  5. Changes well-sliced (not one giant AI commit)

### Merge Conflict Resolution
- **Scope restriction**: "Act Mode. Löse ausschließlich die Merge‑Konfliktmarker in diesen Dateien."
- **No refactors/renaming** during conflict resolution
- **After fix**: `git add -A`, `git commit -m "chore: resolve merge conflicts"`
- **If check.ps1 red after**: Minimal fix only, no architectural cleanup

### Refactor Sprints (controlled)
- **Constraints**: Public API unchanged, behavior identical, tests green after each step
- **Phases**:
  1. Mechanical restructuring
  2. Unification/naming (only if needed)
  3. Performance/fine-tuning (optional)
- **Prompt**: "Plan Mode. Refactor‑Ziel: … Constraints: keine API‑Änderung, Verhalten muss identisch bleiben. Plane in Phasen, jeder Schritt muss nach .\scripts\check.ps1 grün sein."
