;; ============================================================
;; MeTTa Demo 07 — Grounded Functions & Python Interop
;; ============================================================
;; Demonstrates: arithmetic, string ops, type introspection
;; ============================================================

;; ─── Arithmetic ──────────────────────────────────────────

!(+ 1 2)
!(- 10 3)
!(* 6 7)
!(/ 10 3)

;; ─── Comparisons ─────────────────────────────────────────

!(== 42 42)
!(> 100 42)
!(< 3 10)

;; ─── String Operations ───────────────────────────────────

!(:: "Hello, " "MeTTa!")
!(:: "count: "  (:: "value=" 42))

;; ─── Type Introspection ──────────────────────────────────

!(get-type 42)
!(get-type "hello")
!(get-type +)
!(get-type True)

;; ─── Collapse (forced evaluation) ────────────────────────

(= (say-hello) (collapse (display "Hello from MeTTa!\n")))
(say-hello)

;; ─── Conditionals ───────────────────────────────────────

(= (classify $x)
   (if (> $x 0)
     (if (< $x 10) "small" "medium")
     "negative"))

!(classify 5)
!(classify 42)
!(classify -3)
