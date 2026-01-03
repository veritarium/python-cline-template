"""Smoke tests for basic functionality."""

from devproj.main import add


def test_add_smoke() -> None:
    """Smoke test for the add function."""
    assert add(1, 2) == 3
    assert add(0, 0) == 0
    assert add(-1, 1) == 0
    assert add(10, 20) == 30
