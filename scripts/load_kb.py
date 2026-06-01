#!/usr/bin/env python3
"""Load a MeTTa knowledge base and run interactive queries."""
import sys
from hyperon import MeTTa


def main():
    if len(sys.argv) < 2:
        print("Usage: python scripts/load_kb.py <file.metta> [query...]")
        sys.exit(1)

    filename = sys.argv[1]
    queries = sys.argv[2:]

    metta = MeTTa()

    with open(filename) as f:
        code = f.read()

    print(f"Loading {filename}...")
    result = metta.run(code)
    for r in result:
        print(f"  {r}")

    if queries:
        print("\nRunning queries:")
        for q in queries:
            print(f"\n  !({q})")
            result = metta.run(f"!({q})")
            for r in result:
                print(f"  => {r}")

    print("\nEntering interactive REPL (type 'exit' to quit)...")
    while True:
        try:
            line = input("metta> ")
            if line.strip().lower() in ("exit", "quit"):
                break
            result = metta.run(f"!({line})")
            for r in result:
                print(f"  {r}")
        except EOFError:
            break
        except KeyboardInterrupt:
            break


if __name__ == "__main__":
    main()
