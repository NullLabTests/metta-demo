;; ============================================================
;; MeTTa Demo 09 — Spaces & Knowledge Isolation
;; ============================================================
;; Demonstrates: multiple knowledge spaces, cross-condition
;; queries, property joins
;; ============================================================

;; ─── Knowledge in &self ──────────────────────────────────

(Isa Mars planet)
(Isa Venus planet)
(Isa Earth planet)
(color Mars Red)
(color Venus Yellow)
(color Earth Blue)
(orbit Mars 1.52)
(orbit Venus 0.72)
(orbit Earth 1.0)
(has-atmosphere Mars thin)
(has-atmosphere Venus thick)
(has-atmosphere Earth normal)

;; ─── Query &self ────────────────────────────────────────

!(match &self (Isa $x planet) $x)
!(match &self (color Mars $c) $c)

;; ─── Cross-condition Queries ────────────────────────────

!(match &self
  (, (Isa $x planet)
     (color $x Red))
  $x)

!(match &self
  (, (Isa $x planet)
     (orbit $x $d))
  ($x orbits at $d AU))

;; ─── Property Categories ────────────────────────────────

(Red is-a Color)
(Yellow is-a Color)
(Blue is-a Color)

!(match &self
  (, (color $obj $prop)
     ($prop is-a Color))
  ($obj is $prop))

!(match &self
  (, (orbit $body $dist)
     (has-atmosphere $body thick))
  ($body has thick atmosphere at $dist AU))
