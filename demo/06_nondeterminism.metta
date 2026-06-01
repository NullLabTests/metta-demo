;; ============================================================
;; MeTTa Demo 06 — Non-Determinism
;; ============================================================
;; Pattern matching returns several results at once.
;; `superpose` lifts a tuple into the non-deterministic domain;
;; `collapse` does the reverse.
;; ============================================================

;; ─── A non-deterministic source ────────────────────────────

(= (color) red)
(= (color) yellow)
(= (color) green)

!(color)

;; ─── collapse flattens the result ─────────────────────────

!(collapse (color))

;; ─── superpose lifts back into non-det domain ─────────────

!(let $xs (collapse (color))
    (superpose $xs))

;; ─── All pair combinations ────────────────────────────────

(= (bin) 0)
(= (bin) 1)
(= (pair $x $y) ($x $y))

!(pair (bin) (bin))

;; ─── Air-conditioner controller (PLN example) ────────────

(= (ift T $then) $then)

(= (make $x) (ift (makes $y $x)            (start $y)))
(= (make $x) (ift (And (prevents (making $y) (making $x))
                       (makes $z $y))      (stop $z)))

(= (prevents (making (air dry))  (making (air wet)))  T)
(= (prevents (making (air wet))  (making (air dry)))  T)
(= (makes    humidifier  (air wet)) T)
(= (makes    kettle      (air wet)) T)
(= (makes    ventilation (air dry)) T)

(= (is (air dry)) (make (air wet)))
(= (is (air wet)) (make (air dry)))

!(is (air dry))
!(is (air wet))
