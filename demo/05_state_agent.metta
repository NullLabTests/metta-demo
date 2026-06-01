;; ============================================================
;; MeTTa Demo 05 — Stateful Agent
;; ============================================================
;; Demonstrates: state atoms, mutable state, state inspection
;; ============================================================

;; ─── Counter State ───────────────────────────────────────

!(bind! &counter (new-state 0))

(= (get-count) &counter)

!(assertEqual (get-state (get-count)) 0)

!(nop (change-state! &counter 1))
!(assertEqual (get-state (get-count)) 1)

!(nop (change-state! &counter 42))
!(assertEqual (get-state (get-count)) 42)
