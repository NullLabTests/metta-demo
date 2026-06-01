;; ============================================================
;; MeTTa Demo 03 — Type System
;; ============================================================
;; Demonstrates: type declarations, type inference, type checking
;; ============================================================

;; ─── Basic Types ─────────────────────────────────────────

(: Entity Type)
(: Animal Entity)
(: Plant Entity)
(: Dog Animal)
(: Cat Animal)
(: Rose Plant)
(: Tulip Plant)
(: Socrates Animal)

!(get-type Dog)
!(get-type Rose)
!(get-type Socrates)

;; ─── Function Types ─────────────────────────────────────

(: is-mammal (-> Animal Bool))
(: is-plant (-> Plant Bool))

(= (is-mammal Dog) True)
(= (is-mammal Cat) True)
(= (is-plant Rose) True)
(= (is-plant Tulip) True)

!(is-mammal Dog)
!(is-plant Tulip)

;; ─── GADT-style Types ───────────────────────────────────

(: Either (-> Type Type Type))
(: (Left $t) (Either $t $x))
(: (Right $t) (Either $x $t))

!(get-type (Left 5))
!(get-type (Right "hello"))
!(get-type (Left (Dog)))

;; ─── Auto Type Checking ──────────────────────────────────

!(pragma! type-check auto)

!(+ 5 5)
!(+ 5 "string")
