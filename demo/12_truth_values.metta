;; ============================================================
;; MeTTa Demo 10 — PLN-style Truth Values
;; ============================================================
;; The Probabilistic Logic Networks family of reasoning rules
;; operate over `(stv strength confidence)` attachments. We
;; re-implement just enough of PLN here to compute the truth
;; value of a conjunction and of an implication chain.
;; ============================================================

;; ─── Helpers ───────────────────────────────────────────────

(= (s-tv (stv $s $c)) $s)
(= (c-tv (stv $s $c)) $c)
(= (min $a $b)        (if (< $a $b) $a $b))

;; ─── The TV "metarule" for a fact stored in `&self` ────────

(= (TV $x)
   (match &self (.tv $x $stv) $stv))

;; ─── The TV rule for conjunctions (PLN ∧ rule, simple form) ─

(= (TV (And $a $b))
   (stv (min (s-tv (TV $a)) (s-tv (TV $b)))
        (min (c-tv (TV $a)) (c-tv (TV $b)))))

;; ─── The TV rule for implications ─────────────────────────

(= (TV $x)
   (match &self
      (.tv (Implication $y $x) (stv $s $c))
      (stv (* $s (s-tv (TV $y)))
           (* $c (c-tv (TV $y))))))

;; ─── Facts about two propositions ──────────────────────────

(.tv (Evaluation (Predicate P) (Concept A)) (stv 0.5 0.8))
(.tv (Evaluation (Predicate P) (Concept B)) (stv 0.3 0.9))
(.tv (Implication
       (Evaluation (Predicate P) (Concept A))
       (Evaluation (Predicate F) (Concept A)))
     (stv 0.8 1.0))

;; ─── Query 1: conjunction TV ───────────────────────────────

!(TV (And (Evaluation (Predicate P) (Concept A))
          (Evaluation (Predicate P) (Concept B))))

;; ─── Query 2: TV of an inferred atom ───────────────────────

!(TV (Evaluation (Predicate F) (Concept A)))

;; ─── The classical "Fritz" PLN story ───────────────────────

(.tv (Implication
       (And (croaks $x) (eat_flies $x))
       (frog $x))
     (stv 0.9 0.8))

(.tv (croaks    Fritz) (stv 0.95 0.85))
(.tv (eat_flies Fritz) (stv 0.87 0.95))

(.tv (Implication (frog $x) (green $x)) (stv 0.9 1.0))

!(TV (croaks Fritz))
!(TV (frog  Fritz))
!(TV (green Fritz))
