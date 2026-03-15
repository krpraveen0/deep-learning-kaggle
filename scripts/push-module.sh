#!/usr/bin/env bash
# Push a single Kaggle kernel module with retry logic.
#
# Retries automatically on transient Kaggle API errors:
#   - "Maximum batch GPU session count" (too many concurrent GPU sessions)
#   - "Notebook not found"            (transient kernel-not-yet-created state)
#
# Exits 0 on success, 1 on failure after all retries are exhausted.
#
# Usage:
#   scripts/push-module.sh <module-path>
#
# Example:
#   scripts/push-module.sh ./module-04-cnns

set -euo pipefail

MODULE="${1:?Usage: push-module.sh <module-path>}"
KAGGLE="${KAGGLE_CLI:-kaggle}"
MAX_ATTEMPTS=4
RETRY_DELAY=90

PUSH_OUTPUT=""
PUSH_ATTEMPTS=0

while [ "$PUSH_ATTEMPTS" -lt "$MAX_ATTEMPTS" ]; do
  PUSH_ATTEMPTS=$((PUSH_ATTEMPTS + 1))
  PUSH_OUTPUT=$("$KAGGLE" kernels push -p "$MODULE" 2>&1) || true
  echo "$PUSH_OUTPUT"

  if echo "$PUSH_OUTPUT" | grep -qi "maximum batch gpu session\|notebook not found"; then
    if [ "$PUSH_ATTEMPTS" -lt "$MAX_ATTEMPTS" ]; then
      echo "Transient error on attempt $PUSH_ATTEMPTS/$MAX_ATTEMPTS. Retrying in ${RETRY_DELAY}s..."
      sleep "$RETRY_DELAY"
      RETRY_DELAY=$((RETRY_DELAY * 2))
      continue
    fi
  fi

  break
done

if echo "$PUSH_OUTPUT" | grep -qi "kernel push error\|error:"; then
  exit 1
fi
