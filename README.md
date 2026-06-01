<p align="center">
  <a href="https://metta-lang.dev"><img src="https://img.shields.io/badge/MeTTa-Demo%20Suite-2ea44f?logo=rust&logoColor=white"></a>
  <a href="https://github.com/trueagi-io/hyperon-experimental"><img src="https://img.shields.io/badge/Hyperon-experimental-blueviolet"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-blue"></a>
  <a href="https://opencog.org"><img src="https://img.shields.io/badge/OpenCog-Hyperon-orange"></a>
  <a href="https://pypi.org/project/hyperon/"><img src="https://img.shields.io/pypi/v/hyperon?color=green&label=hyperon"></a>
  <a href="https://github.com/NullLabTests/metta-demo"><img src="https://img.shields.io/github/last-commit/NullLabTests/metta-demo"></a>
  <a href="https://github.com/NullLabTests/metta-demo/actions"><img src="https://img.shields.io/badge/Demos-7-brightgreen"></a>
  <a href="#"><img src="https://img.shields.io/badge/AGI-Neuro--Symbolic-ff69b4"></a>
</p>

# OpenCog Hyperon MeTTa — Demo Suite

A comprehensive demo suite for the [MeTTa](https://metta-lang.dev) programming language — the successor to OpenCog Classic's Atomese, built on the [Hyperon](https://github.com/trueagi-io/hyperon-experimental) runtime.

This repo mirrors the [OpenCog AtomSpace Classic demo](https://github.com/NullLabTests/opencog-codespace-demo) in MeTTa. Where Classic uses Scheme (`demo.scm`, `comprehensive-demo.scm`) with `InheritanceLink`, `EvaluationLink`, etc., this demo uses MeTTa's native symbolic expressions, pattern matching, type system, and spaces.

---

## Quick Start

```bash
pip install hyperon
./run.sh
```

Or with Python (annotated output):

```bash
python run_demo.py
```

Or run a single demo directly:

```bash
metta-py demo/01_taxonomy_kb.metta
```

Interactive session with a loaded KB:

```bash
python scripts/load_kb.py demo/01_taxonomy_kb.metta
```

---

## Demo Index

| # | File | Topic | Concepts |
|---|------|-------|----------|
| 1 | `demo/01_taxonomy_kb.metta` | Taxonomy KB | Symbolic expressions, pattern matching, inheritance chains |
| 2 | `demo/02_combinators.metta` | Combinatory Logic | SKI combinators, Peano arithmetic, rewrite rules, recursion |
| 3 | `demo/03_types.metta` | Type System | Type declarations, type inference, higher-order types, auto type checking |
| 4 | `demo/04_logical_reasoning.metta` | Logical Reasoning | Syllogisms, family trees, forward/backward chaining, deduction |
| 5 | `demo/05_state_agent.metta` | Stateful Agent | Mutable state atoms, state monads, counters |
| 6 | `demo/06_spaces.metta` | Spaces | Multiple knowledge spaces, imports, cross-condition queries |
| 7 | `demo/07_grounded_functions.metta` | Grounded Functions | Arithmetic, string ops, type introspection, conditionals |

---

## Features Demonstrated

| MeTTa Feature | Demo(s) |
|---|---|
| Symbolic expressions & atoms | All |
| Pattern matching (`match`) | 1, 4, 6 |
| Rewrite rules (`=`, `:=`) | 2, 3, 4 |
| Recursive functions | 2, 4 |
| Type system (`:`, `get-type`) | 3 |
| Higher-order types & GADTs | 3 |
| Spaces (`&self`, `&kb`) | 6 |
| Cross-space imports | 6 |
| Mutable state (`new-state`, `change-state!`) | 5 |
| Grounded arithmetic, strings, comparisons | 7 |
| Control flow (`if`, `collapse`) | 7 |
| Auto type checking (`pragma!`) | 3 |

---

## Repo Layout

```
metta-demo/
├── README.md                    ← you are here
├── LICENSE                      Apache 2.0
├── .gitignore
├── run.sh                       Run all demos in sequence
├── run_demo.py                  Annotated Python runner
├── scripts/
│   └── load_kb.py               Interactive REPL on a loaded KB
└── demo/
    ├── 01_taxonomy_kb.metta
    ├── 02_combinators.metta
    ├── 03_types.metta
    ├── 04_logical_reasoning.metta
    ├── 05_state_agent.metta
    ├── 06_spaces.metta
    └── 07_grounded_functions.metta
```

---

## Resources

- [MeTTa Website](https://metta-lang.dev)
- [hyperon-experimental on GitHub](https://github.com/trueagi-io/hyperon-experimental)
- [hyperon on PyPI](https://pypi.org/project/hyperon/)
- [MeTTa-WAM](https://github.com/trueagi-io/metta-wam)
- [MeTTa Examples](https://github.com/trueagi-io/metta-examples)
- [OpenCog Hyperon](https://opencog.org)
- [OpenCog AtomSpace (Classic) demo](https://github.com/NullLabTests/opencog-codespace-demo)
- [Hyperon paper on arXiv](https://arxiv.org/abs/2310.18318)

---

## License

**Apache 2.0** — see [LICENSE](LICENSE). The underlying MeTTa runtime (hyperon-experimental) is MIT-licensed by SingularityNET.

---

<p align="center">
  <sub>
    <a href="https://metta-lang.dev">MeTTa-lang.dev</a> ·
    <a href="https://github.com/trueagi-io/hyperon-experimental">Hyperon</a> ·
    <a href="https://opencog.org">OpenCog.org</a>
  </sub>
</p>
