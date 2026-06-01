;; ============================================================
;; MeTTa Demo 08 — Stateful Agent
;; ============================================================
;; Demonstrates: state atoms, mutable state, state monads,
;; typed state transitions
;; ============================================================

;; ─── Counter State ───────────────────────────────────────

!(bind! &counter (new-state 0))

(= (get-count) &counter)

!(println! (get-state (get-count)))

!(nop (change-state! &counter 1))
!(println! (get-state (get-count)))

!(nop (change-state! &counter 42))
!(println! (get-state (get-count)))

;; ─── State Type Inference ────────────────────────────────

!(assertEqual
  (get-type (new-state 2))
  (StateMonad Number))

;; ─── Agent State (compound tuple) ────────────────────────

!(bind! &agent-state (new-state ((position 0 0) (health 100) (score 0))))
(= (get-agent) &agent-state)

!(println! (get-state (get-agent)))

;; ─── Mutate Agent Position ───────────────────────────────

(= (move-agent $dx $dy)
   (let $s (get-state (get-agent))
     (let ($pos $rest) $s
       (let ($x $y) $pos
         (nop (change-state! &agent-state
               ((position (+ $x $dx) (+ $y $dy)) $rest)))))))

(nop (move-agent 3 4))
!(println! (get-state (get-agent)))

(nop (move-agent -1 2))
!(println! (get-state (get-agent)))

;; ─── Encapsulated State via let ──────────────────────────

!(assertEqual
   (let $x (new-state 1)
      (change-state! $x (+ (get-state $x) 1)))
   (new-state 2))

;; ─── Type-safe State Transitions ─────────────────────────

!(assertEqual
  (change-state! (new-state 1) "S")
  (Error (change-state! (new-state 1) "S") (BadArgType 2 Number String)))
