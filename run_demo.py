#!/usr/bin/env python3
"""MeTTa Demo Runner — runs all demos with commentary."""
import subprocess
import sys
import os

DEMOS = [
    ("01_taxonomy_kb.metta",
     "Taxonomy Knowledge Base",
     "Symbolic expressions, pattern matching, inheritance chains"),
    ("02_combinators.metta",
     "Combinatory Logic & Rewriting",
     "SKI combinators, Peano arithmetic, list operations"),
    ("03_types.metta",
     "Type System",
     "Type declarations, type inference, auto type checking"),
    ("04_logical_reasoning.metta",
     "Logical Reasoning",
     "Syllogisms, family trees, recursive ancestor queries"),
    ("05_state_agent.metta",
     "Stateful Agent",
     "Mutable state atoms, counters, encapsulated state"),
    ("06_spaces.metta",
     "Spaces & Knowledge Isolation",
     "Multiple spaces, cross-condition queries"),
    ("07_grounded_functions.metta",
     "Grounded Functions",
     "Arithmetic, string ops, type introspection, conditionals"),
]

SEP = "=" * 68


def run_demo(filepath):
    result = subprocess.run(
        ["metta-py", filepath],
        capture_output=True, text=True, timeout=30
    )
    return result.stdout, result.stderr


def main():
    demo_dir = os.path.join(os.path.dirname(__file__), "demo")

    print(f"\n{SEP}")
    print("  OpenCog Hyperon MeTTa — Full Demo Suite")
    print(f"{SEP}\n")

    passed = 0
    for filename, title, desc in DEMOS:
        filepath = os.path.join(demo_dir, filename)
        print(f"  [{filename}]")
        print(f"  {title}")
        print(f"  {desc}")
        print(f"  {'-' * 64}")

        try:
            stdout, stderr = run_demo(filepath)
            lines = [l for l in stdout.split("\n") if l.strip()]
            for line in lines[:15]:
                print(f"    {line}")
            if len(lines) > 15:
                print(f"    ... ({len(lines) - 15} more results)")
            if stderr:
                print(f"    [stderr]: {stderr.strip()}")
            passed += 1
            status = "PASS"
        except subprocess.TimeoutExpired:
            status = "TIMEOUT"
        except Exception as e:
            status = f"ERROR: {e}"

        print(f"  [{status}]")
        print()

    print(f"{SEP}")
    print(f"  Results: {passed}/{len(DEMOS)} demos completed")
    print(f"{SEP}\n")


if __name__ == "__main__":
    main()
