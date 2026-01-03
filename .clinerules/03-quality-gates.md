# Quality Gates

- New behavior requires tests.
- Bug fixes require a regression test (would fail before fix).
- Before claiming "done", always propose running:
  - .\scripts\check.ps1
- If the gate fails: fix ONLY what is needed to make it pass. No other improvements.
