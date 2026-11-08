#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  printf 'Usage: %s <url>\n' "$0" >&2
  exit 2
fi

url="$1"

if curl --fail --silent --show-error --max-time 5 "$url" >/dev/null; then
  printf 'Health check passed: %s\n' "$url"
else
  printf 'Health check failed: %s\n' "$url" >&2
  exit 1
fi
