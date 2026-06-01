;; ============================================================
;; MeTTa Demo 02 — Combinatory Logic & Rewriting
;; ============================================================
;; Demonstrates: rewrite rules, function composition, recursion
;; ============================================================

;; ─── SKI Combinators ─────────────────────────────────────

(:= (I $x) $x)
(:= ((K $x) $y) $x)
(:= (S $x $y $z) ($x $z ($y $z)))

;; I combinator: I x = x
!(match &self (:= (I (hello world)) $r) $r)

;; K combinator: K x y = x
!(match &self (:= ((K first) second) $r) $r)

;; SKK reduction: S K K x = K x (K x) = x
!(match &self (:= (S K K x) $r) $r)
!(match &self
  (:= (S K K x) $r)
  (match &self (:= $r $r2) $r2))

;; ─── Peano Arithmetic ────────────────────────────────────

(:= (Add $x Z) $x)
(:= (Add $x (S $y)) (Add (S $x) $y))

!(match &self (:= (Add (S Z) (S Z)) $r) $r)
!(match &self
  (:= (Add (S Z) (S Z)) $r)
  (match &self (:= $r $r2) $r2))

;; ─── List Operations ─────────────────────────────────────

(= (length ()) 0)
(= (length ($x . $xs)) (+ 1 (length $xs)))

!(length ())
!(length (a b c d e))
