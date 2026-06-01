;; ============================================================
;; MeTTa Demo 06 — Grounded Functions
;; ============================================================
;; Grounded atoms bridge MeTTa to the host runtime.
;; Arithmetic, comparisons, type checks, and I/O all live here.
;; ============================================================

;; ─── Arithmetic ────────────────────────────────────────────

!(+ 1 2)
!(- 10 3)
!(* 6 7)
!(/ 22 7)
!(% 21 5)

;; ─── Mixed int / float ─────────────────────────────────────

!(+ 2 (* 3 5.5))
!(- 8 (/ 4 6.4))

;; ─── Comparisons ───────────────────────────────────────────

!(== 42 42)
!(== 42 7)
!(> 100 42)
!(< 3 10)
!(<= 5 5)

;; ─── Boolean algebra ───────────────────────────────────────

!(not True)

;; ─── Unreduced expressions when symbols aren't grounded ────

!(ln (+ 2 2))

;; ─── Type errors are reported, not silently swallowed ──────

!(+ 2 "String")
