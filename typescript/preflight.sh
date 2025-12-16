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

# Node + package manager (repo contains package-lock.json and pnpm-lock.yaml)
has node || fail "Node.js is not installed. Install Node.js (LTS recommended) and re-run."
echo "✅ node: $(node -v)"

if has pnpm; then
  echo "✅ pnpm: $(pnpm -v)"
elif has npm; then
  echo "✅ npm: $(npm -v)"
else
  fail "No package manager found (pnpm or npm). Install one and re-run."
fi

# Python (repo contains a python/ directory)
if has python3; then
  echo "✅ python3: $(python3 -V)"
elif has python; then
  echo "✅ python: $(python -V)"
else
  fail "Python is not installed. Install Python 3 and re-run."
fi

# Go (repo contains a go/ directory)
has go || fail "Go is not installed. Install Go and re-run."
echo "✅ go: $(go version)"

echo "🎉 Preflight passed."
