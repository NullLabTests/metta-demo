;; ============================================================
;; MeTTa Demo 01 — Taxonomy Knowledge Base
;; ============================================================
;; Pattern matching, symbolic expressions, inheritance chains
;; ============================================================

;; ─── Taxonomy Facts ─────────────────────────────────────

(Isa cat mammal)
(Isa dog mammal)
(Isa horse mammal)
(Isa dolphin mammal)
(Isa eagle bird)
(Isa snake reptile)
(Isa salmon fish)
(Isa mammal animal)
(Isa reptile animal)
(Isa bird animal)
(Isa fish animal)
(Isa animal living-thing)

;; ─── Property Facts ─────────────────────────────────────

(has-color sky blue)
(has-color grass green)
(has-color snow white)
(has-diet cat carnivore)
(has-diet dog omnivore)
(has-diet horse herbivore)
(can-fly eagle True)
(can-fly cat False)
(can-swim dolphin True)
(can-swim cat False)
(can-swim salmon True)

;; ─── Part 1: Basic Matching ─────────────────────────────

!(match &self (Isa $x mammal) $x)
!(match &self (Isa $x bird) $x)
!(match &self (Isa $x animal) $x)

;; ─── Part 2: Multi-condition Matching ───────────────────

!(match &self
  (, (Isa $x mammal)
     (has-diet $x carnivore))
  $x)

!(match &self
  (, (Isa $x animal)
     (can-fly $x True))
  $x)

;; ─── Part 3: Inherited Properties ──────────────────────

(= (is-animal $x) (Isa $x animal))
(= (is-mammal $x) (Isa $x mammal))

!(is-mammal cat)
!(is-mammal eagle)
!(is-animal dolphin)

;; ─── Part 4: Property Lookup ────────────────────────────

!(match &self (has-color $x blue) $x)
!(match &self (can-swim $x True) $x)
!(match &self (has-diet $x herbivore) $x)
