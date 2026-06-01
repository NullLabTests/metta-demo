#!/usr/bin/env python3
"""MeTTa Demo Runner — runs all 12 demos with commentary."""
import subprocess
import sys
import os

DEMOS = [
    ("01_symbols.metta", "Symbols & Matching", "Atoms, variables, match, expression patterns"),
    ("02_combinators.metta", "Combinatory Logic", "SKI combinators, Peano arithmetic, lists, recursion"),
    ("03_taxonomy.metta", "Taxonomy KB", "Inheritance chains, multi-condition queries"),
    ("04_types.metta", "Type System", "Type hierarchy, GADTs, parametric types, functors"),
    ("05_grounded.metta", "Grounded Functions", "Arithmetic, comparisons, type errors"),
    ("06_nondeterminism.metta", "Non-Determinism", "collapse, superpose, PLN HVAC controller"),
    ("07_state.metta", "State (Simple)", "new-state, change-state!, counter"),
    ("08_state_agent.metta", "State Agent", "Compound state, agent position, typed transitions"),
    ("09_reasoning.metta", "Reasoning", "Socrates syllogism, family tree, recursion"),
    ("10_backchaining.metta", "Backward Chaining", "Deduction, proof trees, Implication"),
    ("11_spaces.metta", "Spaces", "Cross-space queries, property joins"),
    ("12_truth_values.metta", "Truth Values", "PLN stv, conjunction/implication TV, Fritz"),
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
    print("  OpenCog Hyperon MeTTa — Full Demo Suite (12 demos)")
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
                print(f"    [stderr]: {stderr.strip()[:200]}")
            passed += 1
            status = "PASS"
        except subprocess.TimeoutExpired:
            status = "TIMEOUT"
        except Exception as e:
            status = f"ERROR: {e}"

        print(f"  [{status}]")
        print()

    total = len(DEMOS)
    print(f"{SEP}")
    print(f"  Results: {passed}/{total} demos passed")
    print(f"{SEP}\n")
    return 0 if passed == total else 1


if __name__ == "__main__":
    sys.exit(main())
