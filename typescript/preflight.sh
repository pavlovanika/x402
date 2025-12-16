#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "❌ $1" >&2
  exit 1
}

has() {
  command -v "$1" >/dev/null 2>&1
}

echo "🔎 x402 preflight checks"

# Node.js
has node || fail "Node.js is not installed. Install Node.js (LTS recommended)."
echo "✅ node: $(node -v)"

# Package manager
if has pnpm; then
  echo "✅ pnpm: $(pnpm -v)"
elif has npm; then
  echo "✅ npm: $(npm -v)"
else
  fail "No package manager found (pnpm or npm). Install one and re-run."
fi

# Python
if has python3; then
  echo "✅ python3: $(python3 -V)"
elif has python; then
  echo "✅ python: $(python -V)"
else
  fail "Python is not installed. Install Python 3 and re-run."
fi

# Go
has go || fail "Go is not installed. Install Go and re-run."
echo "✅ go: $(go version)"

echo "🎉 Preflight passed."
