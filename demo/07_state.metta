;; ============================================================
;; MeTTa Demo 07 — Stateful Agent
;; ============================================================
;; `new-state` wraps a value in a mutable cell. `bind!` names
;; that cell. MeTTa's state monad is type-checked.
;; ============================================================

;; ─── A typed cell ──────────────────────────────────────────

!(bind! &counter (new-state 0))

(= (get-count) &counter)

!(get-state (get-count))

!(nop (change-state! &counter 1))
!(get-state (get-count))

!(nop (change-state! &counter 42))
!(get-state (get-count))

;; ─── A simple counter function ────────────────────────────

(= (bump!)
   (let $cur (get-state &counter)
     (nop (change-state! &counter (+ $cur 1)))))

!(nop (bump!))
!(nop (bump!))
!(nop (bump!))
!(get-state &counter)
