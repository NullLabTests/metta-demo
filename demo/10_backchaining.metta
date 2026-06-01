;; ============================================================
;; MeTTa Demo 09 — Backward Chaining / Deductive Reasoning
;; ============================================================
;; MeTTa is not just functional programming — it can perform
;; inference. The classic PLN example: Plato is a philosopher,
;; philosophers are human, humans are mortal. Deduce that
;; Plato is mortal — and explain *why*.
;; ============================================================

;; ─── Facts about Plato ─────────────────────────────────────

(Evaluation (philosopher Plato))
(Evaluation (likes-to-wrestle Plato))

;; ─── A rule: philosophers are human ────────────────────────

(Implication
   (And (Evaluation (philosopher $x))
        (Evaluation (likes-to-wrestle $x)))
   (Evaluation (human $x)))

;; ─── A second rule: humans are mortal ──────────────────────

(Implication
   (Evaluation (human $x))
   (Evaluation (mortal $x)))

;; ─── Boolean AND ───────────────────────────────────────────

(= (And T T) T)

;; ─── Generic deduction ─────────────────────────────────────

(= (deduce (Evaluation ($P $x)))
   (match &self (Evaluation ($P $x)) T))

(= (deduce (Evaluation ($P $x)))
   (match &self
      (Implication $a (Evaluation ($P $x)))
      (deduce $a)))

(= (deduce (And $a $b))
   (And (deduce $a) (deduce $b)))

;; ─── Is Plato mortal? ──────────────────────────────────────

!(deduce (Evaluation (mortal Plato)))

;; ─── Who is mortal? (find a binding) ───────────────────────

(= (ift T $then) $then)

!(ift (deduce (Evaluation (mortal $x))) $x)

;; ─── Explain *why* Plato is mortal ─────────────────────────

(= (explain (Evaluation ($P $x)))
   (match &self (Evaluation ($P $x)) ($P $x)))

(= (explain (Evaluation ($P $x)))
   (match &self
      (Implication $a (Evaluation ($P $x)))
      (($P $x) proven by (explain $a))))

(= (explain (And $a $b))
   (And (explain $a) (explain $b)))

!(explain (Evaluation (mortal Plato)))
