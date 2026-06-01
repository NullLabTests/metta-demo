;; ============================================================
;; MeTTa Demo 01 — Symbols, Atoms, and Pattern Matching
;; ============================================================
;; MeTTa's foundation: every program is a tree of atoms.
;; Variables (start with $) bind during pattern matching.
;; `match` searches the current space (&self) for expressions
;; that fit a pattern and returns the matching bindings.
;; ============================================================

;; ─── Symbolic facts ────────────────────────────────────────

(Sam is a frog)
(Tom is a cat)
(Sophia is a robot)

;; ─── match binds one variable ────────────────────────────

!(match &self ($who is a frog) $who)

;; ─── match binds multiple variables ─────────────────────

!(match &self ($who is a $what) ($who the $what))

;; ─── Pattern that doesn't match returns empty ────────────

!(match &self ($who is a unicorn) $who)

;; ─── Expression pattern (rejects sub-expressions) ────────

((leaf1 leaf2) leaf3)
(((leaf0 leaf1) leaf2) leaf3)
(top ((leaf1 leaf2) leaf3))

!(match &self (($x leaf2) leaf3) $x)
