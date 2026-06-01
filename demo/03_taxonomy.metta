;; ============================================================
;; MeTTa Demo 03 — Taxonomy Knowledge Base
;; ============================================================
;; Declare a small biological taxonomy, then query it.
;; Every (match ...) reads from &self (the implicit current space)
;; and returns all bindings that fit the pattern.
;; ============================================================

;; ─── Inheritance facts ─────────────────────────────────────

(Isa cat    mammal)
(Isa dog    mammal)
(Isa horse  mammal)
(Isa eagle  bird)
(Isa salmon fish)
(Isa dolphin mammal)
(Isa mammal animal)
(Isa bird   animal)
(Isa fish   animal)
(Isa reptile animal)
(Isa animal living-thing)

;; ─── Property facts ────────────────────────────────────────

(can-fly eagle  True)
(can-fly cat    False)
(can-swim salmon  True)
(can-swim dolphin True)
(can-swim cat     False)
(has-diet cat   carnivore)
(has-diet horse herbivore)
(has-diet dog   omnivore)

;; ─── Query 1: all mammals ──────────────────────────────────

!(match &self (Isa $x mammal) $x)

;; ─── Query 2: all birds ────────────────────────────────────

!(match &self (Isa $x bird) $x)

;; ─── Query 3: every animal ─────────────────────────────────

!(match &self (Isa $x animal) $x)

;; ─── Query 4: carnivorous mammals (multi-condition) ────────

!(match &self
   (, (Isa $x mammal)
      (has-diet $x carnivore))
   $x)

;; ─── Query 5: flying animals ───────────────────────────────

!(match &self
   (, (Isa $x animal)
      (can-fly $x True))
   $x)

;; ─── Query 6: swimmers ─────────────────────────────────────

!(match &self (can-swim $x True) $x)

;; ─── Derive: a mammal is an animal (chain via 2 facts) ─────

!(match &self
   (, (Isa $x mammal)
      (Isa mammal animal))
   (MammalChain $x is animal))
