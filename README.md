<p align="center">
  <a href="https://metta-lang.dev"><img src="https://img.shields.io/badge/MeTTa-Demo%20Suite-2ea44f?logo=rust&logoColor=white"></a>
  <a href="https://github.com/trueagi-io/hyperon-experimental"><img src="https://img.shields.io/badge/Hyperon-experimental-blueviolet"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-blue"></a>
  <a href="https://opencog.org"><img src="https://img.shields.io/badge/OpenCog-Hyperon-orange"></a>
  <a href="https://pypi.org/project/hyperon/"><img src="https://img.shields.io/pypi/v/hyperon?color=green&label=hyperon"></a>
  <a href="https://github.com/NullLabTests/metta-demo"><img src="https://img.shields.io/github/last-commit/NullLabTests/metta-demo"></a>
  <a href="https://github.com/NullLabTests/metta-demo/actions"><img src="https://img.shields.io/badge/Demos-12-brightgreen"></a>
  <a href="#"><img src="https://img.shields.io/badge/AGI-Neuro--Symbolic-ff69b4"></a>
</p>

<h1 align="center">🧠 OpenCog Hyperon MeTTa — Demo Suite</h1>

<p align="center">
  <em>12 interactive demos • 624 lines of MeTTa • Built on hyperon-experimental v0.2.10 (Rust) + PyPI hyperon</em>
</p>

<p align="center">
  <img src="assets/repl-demo.gif" alt="Live MeTTa REPL session" width="720">
  <br>
  <em>Live MeTTa REPL session: atoms, pattern matching, type queries.</em>
</p>

---

## What is MeTTa?

**MeTTa (Meta Type Talk)** is the successor to OpenCog Classic's Atomese — an "Atomese 2" for the [OpenCog Hyperon](https://opencog.org) AGI architecture. It is a symbolic expression language with:

- **Pattern matching** as the core computation primitive
- **Dependent types** for expressing logical constraints
- **Spaces** for knowledge isolation and modularity
- **Mutable state** via state monads
- **Grounded functions** for host-language interop (Python, Rust)
- **Rewriting rules** for graph transformation and inference
- **Non-determinism** — queries return *all* matching results

Implemented in Rust by [TrueAGI](https://trueagi.io) ([hyperon-experimental](https://github.com/trueagi-io/hyperon-experimental)) and available on [PyPI](https://pypi.org/project/hyperon/).

---

## Quick Start

```bash
pip install hyperon
./run.sh                    # Run all 12 demos in sequence
python run_demo.py          # Annotated output with pass/fail
metta-py demo/01_symbols.metta  # Single demo
python scripts/load_kb.py demo/03_taxonomy.metta  # Interactive
```

---

## Demo Index

| # | File | Topic | Concepts | Lines |
|---|------|-------|----------|-------|
| 1 | `demo/01_symbols.metta` | Symbols & Matching | Atoms, variables, `match`, expression patterns | 35 |
| 2 | `demo/02_combinators.metta` | Combinatory Logic | SKI combinators, Peano arithmetic, lists, recursion | 87 |
| 3 | `demo/03_taxonomy.metta` | Taxonomy KB | Inheritance chains, property queries, multi-condition joins | 70 |
| 4 | `demo/04_types.metta` | Type System | Type hierarchy, function types, GADTs, parametric types, functors | 66 |
| 5 | `demo/05_grounded.metta` | Grounded Functions | Arithmetic, comparisons, string ops, type errors | 45 |
| 6 | `demo/06_nondeterminism.metta` | Non-Determinism | `collapse`, `superpose`, HVAC controller (PLN example) | 66 |
| 7 | `demo/07_state.metta` | State (Simple) | `new-state`, `change-state!`, `bind!`, counter | 40 |
| 8 | `demo/08_state_agent.metta` | State Agent | Compound state, agent position/health, typed transitions | 65 |
| 9 | `demo/09_reasoning.metta` | Reasoning | Socrates syllogism, family tree, recursive ancestor | 43 |
| 10 | `demo/10_backchaining.metta` | Backward Chaining | Deduction, proof trees, `Implication`, `explain` | 68 |
| 11 | `demo/11_spaces.metta` | Spaces | Multi-space queries, cross-condition joins | 49 |
| 12 | `demo/12_truth_values.metta` | Truth Values | PLN `stv`, conjunction/implication TV rules, Fritz story | 67 |

---

## Features Demonstrated

| MeTTa Feature | Demo(s) | Lines of code |
|---|---|---|
| `match` pattern matching | 1, 3, 9, 11 | ~20 |
| `=` function definition | 2, 5, 6, 7, 8, 9, 10, 12 | ~60 |
| `(: ...)` type declarations | 2, 4, 9 | ~30 |
| `get-type` type inference | 4 | ~10 |
| `new-state` / `change-state!` | 7, 8 | ~25 |
| `bind!` token binding | 7, 8 | ~5 |
| GADT & parametric types | 4 | ~15 |
| `collapse` / `superpose` | 6 | ~8 |
| Grounded arithmetic | 2, 5 | ~15 |
| `if` conditionals | 5, 6, 12 | ~8 |
| `let` bindings | 6, 7, 8 | ~10 |
| `assertEqual` / `println!` | 4, 7, 8 | ~10 |
| Recursive functions | 2, 9 | ~15 |
| Backward chaining | 10 | ~30 |
| PLN-style truth values | 12 | ~40 |

---

## Architecture

<p align="center">
  <img src="assets/architecture.svg" alt="Hyperon Architecture" width="600">
  <br>
  <em>Hyperon system architecture: Rust core, C API, Python bindings, REPL.</em>
</p>

<p align="center">
  <img src="assets/data-flow.svg" alt="Data Flow" width="600">
  <br>
  <em>Data flow through the MeTTa interpreter pipeline.</em>
</p>

<p align="center">
  <img src="assets/query-pipeline.svg" alt="Query Pipeline" width="600">
  <br>
  <em>Pattern matching pipeline: atom indexing → unification → result streaming.</em>
</p>

### Component Stack

```
metta-py  (CLI / REPL)       ← pip install hyperon
hyperon  (Python lib)        ← Python API
libhyperonpy  (pybind11)     ← C++/Python bridge
libhyperonc  (C API)         ← C bindings
hyperon-common / -atom / -space  ← Rust crates
libhyperon  (Rust core)      ← interpreter, matcher, type system
```

### Build Options & Times (4 cores)

| Component | Time | Command |
|---|---|---|
| Rust core | ~3 min | `cargo build --release` |
| C/Python API | ~3 min | `cmake --build .` |
| Docker | ~8 min | `docker build -t trueagi/hyperon .` |
| **PyPI install** | **5 sec** | `pip install hyperon` |

See [hyperon-experimental/README.md](https://github.com/trueagi-io/hyperon-experimental) for full build instructions.

---

## Repo Layout

```
metta-demo/
├── README.md                 ← you are here
├── LICENSE                   Apache 2.0
├── .gitignore
├── run.sh                    Run all 12 demos (shell)
├── run_demo.py               Annotated Python runner
├── scripts/
│   └── load_kb.py            Interactive REPL on a loaded KB
├── assets/
│   ├── repl-demo.gif          Animated REPL (2.4 MB)
│   ├── architecture.svg       Hyperon architecture
│   ├── data-flow.svg          Interpreter pipeline
│   └── query-pipeline.svg     Pattern matching pipeline
└── demo/
    ├── 01_symbols.metta        Symbols & pattern matching
    ├── 02_combinators.metta    SKI combinators & Peano arithmetic
    ├── 03_taxonomy.metta       Taxonomy knowledge base
    ├── 04_types.metta          Type system & functors
    ├── 05_grounded.metta       Grounded functions
    ├── 06_nondeterminism.metta Non-determinism & PLN HVAC
    ├── 07_state.metta          Simple mutable state
    ├── 08_state_agent.metta    Compound agent state
    ├── 09_reasoning.metta      Syllogisms & family trees
    ├── 10_backchaining.metta   Deduction & proof trees
    ├── 11_spaces.metta         Spaces & cross-condition queries
    └── 12_truth_values.metta   PLN truth value propagation
```

---

## Classic → MeTTa Mapping

| OpenCog Classic (Atomese) | MeTTa equivalent |
|---|---|
| `InheritanceLink (C "cat") (C "mammal")` | `(Isa cat mammal)` |
| `EvaluationLink (Predicate "fly") (ListLink (C "eagle"))` | `(can-fly eagle True)` |
| `GetLink ...` / `BindLink ...` | `(match &self pattern result)` |
| `(cog-evaluate! (Plus (Number 1) (Number 2)))` | `!(+ 1 2)` |
| `StateLink` | `(new-state ...)` / `(change-state! ...)` |
| `cog-execute!` | `!` prefix |
| Typed variables | `(: name type)` declarations |
| `(cog-count-atoms)` | No direct equivalent (use match + collapse) |

---

## Resources

| Resource | Link |
|---|---|
| MeTTa Language | https://metta-lang.dev |
| hyperon-experimental (Rust) | https://github.com/trueagi-io/hyperon-experimental |
| hyperon (PyPI) | https://pypi.org/project/hyperon/ |
| MeTTa-WAM (Prolog) | https://github.com/trueagi-io/metta-wam |
| MeTTa Spec | https://wiki.opencog.org/w/File:MeTTa_Specification.pdf |
| Hyperon Docs | https://trueagi-io.github.io/hyperon-experimental |
| OpenCog Hyperon | https://opencog.org |
| OpenCog Classic Demo | https://github.com/NullLabTests/opencog-codespace-demo |
| Hyperon arXiv paper | https://arxiv.org/abs/2310.18318 |

---

## Development

```bash
git clone https://github.com/NullLabTests/metta-demo
cd metta-demo
pip install hyperon
vim demo/04_types.metta
metta-py demo/04_types.metta
./run.sh
```

---

## License

**Apache 2.0** — see [LICENSE](LICENSE). MeTTa runtime (hyperon-experimental) is MIT-licensed by SingularityNET / TrueAGI.

---

<p align="center">
  <sub>
    <a href="https://metta-lang.dev">MeTTa-lang.dev</a> ·
    <a href="https://github.com/trueagi-io/hyperon-experimental">Hyperon</a> ·
    <a href="https://opencog.org">OpenCog.org</a> ·
    <a href="https://github.com/NullLabTests/opencog-codespace-demo">Classic Demo</a> ·
    Built with <a href="https://opencode.ai">OpenCode</a>
  </sub>
</p>
