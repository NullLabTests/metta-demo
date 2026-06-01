#!/usr/bin/env bash
# ============================================================
# MeTTa Demo Runner — Execute all demo scripts sequentially
# ============================================================
# Mirrors the opencog-codespace-demo run-all-demos.sh pattern
# but targets the MeTTa (Hyperon) interpreter via metta-py
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
FAILED_SCRIPTS=()

print_banner() {
    cat <<'BANNER'
  __  __          _   _____  __
 |  \/  | ___  __| | |  ___|| |
 | |\/| |/ _ \/ _` | | |_   | |
 | |  | |  __/ (_| | |  _|  | |___
 |_|  |_|\___|\__,_| |_|    |_____|
  Hyperon / MeTTa — Demo Runner
BANNER
    echo ""
    echo "Interpreter : ${INTERPRETER}"
    echo "Demo dir    : ${DEMO_DIR}"
    echo "Timeout     : ${TIMEOUT_SECS}s per demo"
    echo "=========================================="
    echo ""
}

check_requirements() {
    if ! command -v "${INTERPRETER}" >/dev/null 2>&1; then
        echo "ERROR: '${INTERPRETER}' not found on PATH." >&2
        echo "       Install with:  python3 -m pip install hyperon" >&2
        echo "       Or set METTA=/path/to/metta-py" >&2
        exit 127
    fi
    if [ ! -d "${DEMO_DIR}" ]; then
        echo "ERROR: demo directory not found: ${DEMO_DIR}" >&2
        exit 1
    fi
}

run_one() {
    local script="$1"
    TOTAL=$((TOTAL + 1))
    local name
    name="$(basename "$script")"
    printf "  [....] %-40s" "$name"

    local start end elapsed output
    start=$(date +%s)
    if output=$(timeout "${TIMEOUT_SECS}" "${INTERPRETER}" "$script" 2>&1); then
        end=$(date +%s)
        elapsed=$((end - start))
        printf "\r  [PASS] %-40s %4ds\n" "$name" "$elapsed"
        PASS=$((PASS + 1))
    else
        local rc=$?
        end=$(date +%s)
        elapsed=$((end - start))
        printf "\r  [FAIL] %-40s %4ds (rc=%d)\n" "$name" "$elapsed" "$rc"
        FAIL=$((FAIL + 1))
        FAILED_SCRIPTS+=("$name")
        if [ "${VERBOSE:-0}" = "1" ]; then
            echo "       --- output (last 8 lines) ---"
            echo "$output" | tail -8 | sed 's/^/         /'
            echo "       ------------------------------"
        fi
    fi
}

main() {
    print_banner
    check_requirements

    shopt -s nullglob
    local scripts=("${DEMO_DIR}"/*.metta)
    shopt -u nullglob

    if [ "${#scripts[@]}" -eq 0 ]; then
        echo "No .metta scripts found in ${DEMO_DIR}"
        exit 1
    fi

    for s in "${scripts[@]}"; do
        run_one "$s"
    done

    echo ""
    echo "=========================================="
    printf "  Results: %d/%d passed, %d failed\n" "$PASS" "$TOTAL" "$FAIL"
    echo "=========================================="

    if [ "$FAIL" -gt 0 ]; then
        echo ""
        echo "Failed scripts:"
        for s in "${FAILED_SCRIPTS[@]}"; do
            echo "  - $s"
        done
        echo ""
        echo "Re-run with VERBOSE=1 to see failing output."
        exit "$FAIL"
    fi
    exit 0
}

main "$@"
