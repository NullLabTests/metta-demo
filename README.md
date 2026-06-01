# OpenCog Hyperon MeTTa — Demo Suite

A comprehensive demo suite for the [MeTTa](https://metta-lang.dev) programming language — the successor to OpenCog Classic's Atomese.

Built with [hyperon-experimental](https://github.com/trueagi-io/hyperon-experimental) ([pypi](https://pypi.org/project/hyperon/)).

## Quick Start

```bash
pip install hyperon
./run.sh
```

Or with Python:

```bash
python run_demo.py
```

## Demos

| # | File | Topic | Concepts |
|---|------|-------|----------|
| 1 | `demo/01_taxonomy_kb.metta` | Taxonomy KB | Symbolic expressions, pattern matching, inheritance |
| 2 | `demo/02_combinators.metta` | Combinatory Logic | SKI combinators, Peano arithmetic, rewrite rules |
| 3 | `demo/03_types.metta` | Type System | Type declarations, type inference, auto type checking |
| 4 | `demo/04_logical_reasoning.metta` | Logical Reasoning | Syllogisms, family trees, recursive deduction |
| 5 | `demo/05_state_agent.metta` | Stateful Agent | Mutable state atoms, state monads |
| 6 | `demo/06_spaces.metta` | Spaces | Multiple knowledge spaces, cross-space queries |
| 7 | `demo/07_grounded_functions.metta` | Grounded Functions | Arithmetic, strings, type introspection, conditionals |

## Running a Single Demo

```bash
metta-py demo/01_taxonomy_kb.metta
```

## Interactive Session

```bash
python scripts/load_kb.py demo/01_taxonomy_kb.metta
```

Then type queries like:

```
match &self (Isa $x mammal) $x
match &self (has-diet $x carnivore) $x
```

## Relationship to OpenCog Classic

This repo mirrors the [OpenCog AtomSpace Classic demo](https://github.com/opencog/opencog-codespace-demo) in MeTTa. Where Classic uses Scheme (`demo.scm`, `comprehensive-demo.scm`) with `InheritanceLink`, `EvaluationLink`, etc., this demo uses MeTTa's native symbolic expressions and pattern matching.

## Resources

- [MeTTa Website](https://metta-lang.dev)
- [hyperon-experimental](https://github.com/trueagi-io/hyperon-experimental)
- [MeTTa-WAM](https://github.com/trueagi-io/metta-wam)
- [OpenCog Hyperon](https://opencog.org)
