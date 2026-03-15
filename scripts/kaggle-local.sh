#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"

if [[ -x "$ROOT_DIR/venv/bin/kaggle" ]]; then
  KAGGLE_CLI="$ROOT_DIR/venv/bin/kaggle"
else
  KAGGLE_CLI="kaggle"
fi

require_env() {
  if [[ ! -f "$ENV_FILE" ]]; then
    echo "Missing .env at $ENV_FILE"
    exit 1
  fi

  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a

  if [[ -z "${KAGGLE_USERNAME:-}" || -z "${KAGGLE_KEY:-}" ]]; then
    echo "KAGGLE_USERNAME or KAGGLE_KEY missing in .env"
    exit 1
  fi
}

setup_auth() {
  require_env
  mkdir -p "$HOME/.kaggle"

  # Support both legacy and token auth modes.
  printf '{"username":"%s","key":"%s"}\n' "$KAGGLE_USERNAME" "$KAGGLE_KEY" > "$HOME/.kaggle/kaggle.json"
  printf '%s' "$KAGGLE_KEY" > "$HOME/.kaggle/access_token"
  chmod 600 "$HOME/.kaggle/kaggle.json" "$HOME/.kaggle/access_token"

  echo "Kaggle auth files written to ~/.kaggle"
}

kaggle_test() {
  setup_auth
  "$KAGGLE_CLI" kernels list -m | head -n 10
}

push_one() {
  local module="$1"
  setup_auth

  if [[ ! -d "$ROOT_DIR/$module" ]]; then
    echo "Module folder not found: $module"
    exit 1
  fi

  if [[ ! -f "$ROOT_DIR/$module/notebook.ipynb" || ! -f "$ROOT_DIR/$module/kernel-metadata.json" ]]; then
    echo "Missing notebook.ipynb or kernel-metadata.json in $module"
    exit 1
  fi

  "$KAGGLE_CLI" kernels push -p "$ROOT_DIR/$module"
}

push_all() {
  setup_auth

  local failed=0
  while IFS= read -r module; do
    if [[ ! -f "$module/notebook.ipynb" || ! -f "$module/kernel-metadata.json" ]]; then
      continue
    fi

    echo "Deploying $(basename "$module")..."
    if ! "$KAGGLE_CLI" kernels push -p "$module"; then
      failed=$((failed + 1))
    fi
    sleep 3
  done < <(find "$ROOT_DIR" -maxdepth 1 -type d -name 'module-*' | sort)

  if [[ "$failed" -gt 0 ]]; then
    echo "Completed with $failed failed module(s)."
    exit 1
  fi

  echo "All modules deployed successfully."
}

usage() {
  cat <<'EOF'
Usage:
  scripts/kaggle-local.sh auth
  scripts/kaggle-local.sh test
  scripts/kaggle-local.sh push <module-folder>
  scripts/kaggle-local.sh push-all
EOF
}

main() {
  local cmd="${1:-}"
  case "$cmd" in
    auth)
      setup_auth
      ;;
    test)
      kaggle_test
      ;;
    push)
      if [[ $# -lt 2 ]]; then
        usage
        exit 1
      fi
      push_one "$2"
      ;;
    push-all)
      push_all
      ;;
    *)
      usage
      exit 1
      ;;
  esac
}

main "$@"
