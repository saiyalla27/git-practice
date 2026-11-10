#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  printf 'Usage: %s <url>\n' "$0" >&2
  exit 2
fi

url="$1"
max_attempts=3
retry_delay=2

for ((attempt = 1; attempt <= max_attempts; attempt++)); do
  if curl --fail --silent --show-error --max-time 5 "$url" >/dev/null; then
    printf 'Health check passed: %s\n' "$url"
    exit 0
  fi

  if ((attempt < max_attempts)); then
    sleep "$retry_delay"
  fi
done

printf 'Health check failed after %s attempts: %s\n' "$max_attempts" "$url" >&2
exit 1
