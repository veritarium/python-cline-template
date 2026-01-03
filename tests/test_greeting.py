"""Test suite for the greeting module."""

import sys

import pytest

from devproj.main import greet, main


class TestGreetFunction:
    """Test cases for the greet() function."""

    def test_greet_default_parameters(self):
        """Test greet() with default parameters."""
        result = greet()
        assert result == "Greeted World 10 times"

    def test_greet_custom_name(self):
        """Test greet() with custom name."""
        result = greet("Alice")
        assert result == "Greeted Alice 10 times"

    def test_greet_custom_count(self):
        """Test greet() with custom count."""
        result = greet("Bob", 3)
        assert result == "Greeted Bob 3 times"

    def test_greet_zero_count(self):
        """Test greet() with zero count."""
        result = greet("Charlie", 0)
        assert result == "Greeted Charlie 0 times"

    def test_greet_negative_count_raises_error(self):
        """Test that greet() raises ValueError for negative count."""
        with pytest.raises(ValueError, match="Count cannot be negative: -1"):
            greet("Test", -1)

    def test_greet_output_capturing(self, capsys):
        """Test that greet() prints the correct output."""
        greet("Test", 2)
        captured = capsys.readouterr()
        assert captured.out == "Hello, Test!\nHello, Test!\n"


class TestMainFunction:
    """Test cases for the main() function."""

    def test_main_output(self, capsys):
        """Test the complete output of main()."""
        main()
        captured = capsys.readouterr()
        output = captured.out

        # Check for expected sections
        assert "=== Simple Greeting Program ===" in output
        assert "=== Custom Greeting ===" in output
        assert "=== Error Handling Example ===" in output
        assert "=== Program Complete ===" in output

        # Check for specific greetings
        assert "Hello, World!" in output
        assert "Hello, Python Developer!" in output

        # Check result messages
        assert "Result: Greeted World 10 times" in output
        assert "Result: Greeted Python Developer 5 times" in output

        # Check error handling message
        assert "Caught expected error: Count cannot be negative: -1" in output

    def test_main_as_script(self, capsys):
        """Test that __main__ guard works correctly."""
        # Temporarily replace sys.argv
        original_argv = sys.argv
        sys.argv = ["devproj/main.py"]

        try:
            # Import and run the module as script
            import devproj.main

            devproj.main.main()
        finally:
            sys.argv = original_argv

        captured = capsys.readouterr()
        assert "=== Simple Greeting Program ===" in captured.out


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
