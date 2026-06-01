;; ============================================================
;; MeTTa Demo 04 — Type System
;; ============================================================
;; `:` assigns a type to an atom; `->` builds a function type.
;; `get-type` reads a type from the space. Type mismatches
;; become visible instead of crashing silently.
;; ============================================================

;; ─── Type hierarchy ────────────────────────────────────────

(: Entity  Type)
(: Animal  Entity)
(: Plant   Entity)
(: Dog     Animal)
(: Cat     Animal)
(: Rose    Plant)
(: Tulip   Plant)

!(get-type Dog)
!(get-type Rose)

;; ─── Function types ───────────────────────────────────────

(: is-mammal (-> Animal Bool))
(=  (is-mammal Dog) True)
(=  (is-mammal Cat) True)

!(is-mammal Dog)

;; ─── Higher-order types ────────────────────────────────────

(: double (-> Number Number))
(=  (double $x) (* $x 2))

(: apply (-> (-> $a $b) $a $b))
(=  (apply $f $x) ($f $x))

!(apply double 21)

;; ─── Parametric / GADT-style types ─────────────────────────

(: Either (-> Type Type Type))
(: (Left  $t) (Either $t $x))
(: (Right $t) (Either $x $t))

!(get-type (Left Dog))
!(get-type (Right "hello"))

;; ─── Generic functor ───────────────────────────────────────

(: Maybe (-> $t Type))
(: Nothing      (Maybe $t))
(: Something    (-> $t (Maybe $t)))

(: fmap (-> (-> $a $b) ($F $a) ($F $b)))
(= (fmap $f ($C0))           ($C0))
(= (fmap $f ($C $x))         ($C ($f $x)))
(= (fmap $f ($C $x $xs))     ($C ($f $x) (fmap $f $xs)))

(= (inc $x) (+ $x 1))
!(fmap inc (Something 5))
!(fmap inc (Nothing))
