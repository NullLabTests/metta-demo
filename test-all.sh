#!/usr/bin/env bash
# ============================================================
# MeTTa Demo Test — Validate expected tokens in each demo
# ============================================================
# Like run-all.sh, but also asserts that specific output
# substrings appear, guarding against silent regressions.
# ============================================================
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/demo"
INTERPRETER="${METTA:-metta-py}"
TIMEOUT_SECS="${TIMEOUT:-15}"
PASS=0
FAIL=0
TOTAL=0
FAILED=()

# test_demo <script> <expected_substring_1> [expected_substring_2 ...]
test_demo() {
    local script="$1"
    shift
    local name
    name="$(basename "$script")"
    TOTAL=$((TOTAL + 1))

    local output rc=0
    output=$(timeout "${TIMEOUT_SECS}" "${INTERPRETER}" "$script" 2>&1) || rc=$?

    if [ "$rc" -ne 0 ]; then
        FAIL=$((FAIL + 1))
        FAILED+=("$name (interpreter exit $rc)")
        printf "  [FAIL] %-40s exit=%d\n" "$name" "$rc"
        return
    fi

    local missing=()
    for needle in "$@"; do
        if ! grep -qF -- "$needle" <<<"$output"; then
            missing+=("$needle")
        fi
    done

    if [ "${#missing[@]}" -eq 0 ]; then
        PASS=$((PASS + 1))
        printf "  [PASS] %-40s %d assertion(s)\n" "$name" "$#"
    else
        FAIL=$((FAIL + 1))
        FAILED+=("$name (missing: ${missing[*]})")
        printf "  [FAIL] %-40s missing: %s\n" "$name" "${missing[*]}"
    fi
}

main() {
    echo "=== MeTTa Demo Test Suite ==="
    echo "Interpreter: ${INTERPRETER}"
    echo "=========================================="
    echo ""

    if ! command -v "${INTERPRETER}" >/dev/null 2>&1; then
        echo "ERROR: '${INTERPRETER}' not found." >&2
        exit 127
    fi

    test_demo "${DEMO_DIR}/01_taxonomy_kb.metta" \
        "cat" "dolphin" "salmon" "horse" "sky"

    test_demo "${DEMO_DIR}/02_combinators.metta" \
        "hello world" "first" "120" "55" "5"

    test_demo "${DEMO_DIR}/03_types.metta" \
        "Animal" "Plant" "True" "42"

    test_demo "${DEMO_DIR}/04_logical_reasoning.metta" \
        "Mortal Socrates" "charlie" "True"

    test_demo "${DEMO_DIR}/05_state_agent.metta" \
        "()" "()"

    test_demo "${DEMO_DIR}/06_spaces.metta" \
        "Mars" "Venus" "Earth" "Red" "1.52"

    test_demo "${DEMO_DIR}/07_grounded_functions.metta" \
        "3" "42" "True" "Number" "String" "small" "medium" "negative"

    echo ""
    echo "=========================================="
    printf "  Results: %d/%d passed, %d failed\n" "$PASS" "$TOTAL" "$FAIL"
    echo "=========================================="

    if [ "$FAIL" -gt 0 ]; then
        echo ""
        echo "Failures:"
        for f in "${FAILED[@]}"; do
            echo "  - $f"
        done
    fi
    exit "$FAIL"
}

main "$@"
