#!/usr/bin/env bash
# Run all MeTTa demos
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== MeTTa Demo Suite ==="
echo ""

for f in "$SCRIPT_DIR/demo"/0*.metta; do
    name="$(basename "$f")"
    echo "--- $name ---"
    metta-py "$f"
    echo ""
done

echo "=== All demos complete ==="
