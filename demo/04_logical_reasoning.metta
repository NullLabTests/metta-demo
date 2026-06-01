;; ============================================================
;; MeTTa Demo 04 — Logical Reasoning
;; ============================================================
;; Demonstrates: deduction, family trees, predicate logic
;; ============================================================

;; ─── Syllogism (Socrates) ─────────────────────────────────

(: Human Type)
(: Mortal (-> Human Type))

(: Socrates Human)
(: Plato Human)

(: AllHumansAreMortal
  (-> (Human $x)
      (Mortal $x)))
(AllHumansAreMortal Socrates)
(AllHumansAreMortal Plato)

!(match &self (AllHumansAreMortal $who) (Mortal $who))

;; ─── Family Tree ─────────────────────────────────────────

(parent alice bob)
(parent bob charlie)
(parent charlie diana)

(= (grandparent $x $y)
   (match &self (parent $x $z)
     (match &self (parent $z $y)
       $y)))

!(grandparent alice charlie)
!(grandparent bob diana)

;; ─── Ancestor (recursive) ────────────────────────────────

(= (ancestor $x $y)
   (parent $x $y))
(= (ancestor $x $y)
   (match &self (parent $x $z)
     (ancestor $z $y)))

!(ancestor alice charlie)
!(ancestor alice diana)

;; ─── Predicate Logic ─────────────────────────────────────

(: human (-> Symbol Bool))
(: mortal (-> Symbol Bool))

(= (human Socrates) True)
(= (human Plato) True)
(= (human Aristotle) True)

(= (mortal $x) (human $x))

!(mortal Socrates)
!(mortal Plato)
