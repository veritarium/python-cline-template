# PR Template (Punkt 12.3)

## PR Description Template
Use this template when creating PRs after Cline-assisted work:

```
## Motivation
[Briefly explain why this change is needed]

## Changes
- [Bullet point 1: what changed in file X]
- [Bullet point 2: what changed in file Y]
- [Bullet point 3: test updates/additions]

## Tests
- [ ] `.\scripts\check.ps1` passes (Ruff lint, Ruff format, pytest)
- [ ] New behavior has tests (would fail if broken)
- [ ] Bug fixes include regression tests (would fail before fix)

## Risks & Notes
- [Any breaking changes?]
- [Dependencies added/changed?]
- [Configuration changes?]
- [Known limitations or follow-up work needed?]
```

## Review Checklist (5-minute review)
1. **Behavior matches acceptance criteria**: Does the PR do what was intended?
2. **Tests are meaningful**: Would tests fail if the implementation was broken?
3. **Scope maintained**: No "side work" or unrelated refactors
4. **Quality gate green**: `.\scripts\check.ps1` passes
5. **Changes well-sliced**: Not one giant AI commit, but logical increments

## PR Creation Prompt (Plan Mode)
When ready to create a PR, use:
```
Plan Mode.
Schreibe eine PR‑Beschreibung mit: Motivation, Änderungen (bullets), Tests (wie ausgeführt), Risiken/Notes.
```

## Commit Message Examples
- `feat(core): add new feature X`
- `fix(cli): resolve issue with Y parameter`
- `test: add regression test for bug Z`
- `chore: update documentation`
- `docs: update BOOTSTRAP.md with Cline workflow`
