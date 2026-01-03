"""Main module for DevProj Cline Setup."""


def add(a: int, b: int) -> int:
    """Add two integers.

    Args:
        a: First integer
        b: Second integer

    Returns:
        Sum of a and b
    """
    return a + b


def greet(name: str = "World", count: int = 10) -> str:
    """
    Greet someone multiple times.

    Args:
        name: The name to greet (default: "World")
        count: Number of times to greet (default: 10)

    Returns:
        A string summarizing the greeting

    Raises:
        ValueError: If count is negative
    """
    if count < 0:
        raise ValueError(f"Count cannot be negative: {count}")

    for _i in range(count):
        print(f"Hello, {name}!")

    return f"Greeted {name} {count} times"


def main() -> None:
    """Main function to demonstrate the greeting."""
    print("=== Simple Greeting Program ===")

    try:
        # Default greeting
        result = greet()
        print(f"\nResult: {result}")

        # Custom greeting
        print("\n=== Custom Greeting ===")
        result = greet("Python Developer", 5)
        print(f"Result: {result}")

        # Demonstrate error handling
        print("\n=== Error Handling Example ===")
        try:
            result = greet("Test", -1)
        except ValueError as e:
            print(f"Caught expected error: {e}")

    except Exception as e:
        print(f"\nUnexpected error: {e}")
        return

    print("\n=== Program Complete ===")


if __name__ == "__main__":
    main()
