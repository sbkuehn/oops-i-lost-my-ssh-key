#!/usr/bin/env bash
# ==============================================================================
# Generate a new SSH key pair for Azure VM access
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  generate-ssh-key.sh --key-path <path> [--comment <comment>] [--type <type>]

Options:
  --key-path   Full path to the private key to create
  --comment    Comment to embed in the public key
  --type       Key type. Defaults to ed25519
  -h, --help   Show this help message
EOF
}

KEY_PATH=""
KEY_TYPE="ed25519"
KEY_COMMENT="azure-vm-access"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --key-path) KEY_PATH="${2:-}"; shift 2 ;;
    --comment) KEY_COMMENT="${2:-}"; shift 2 ;;
    --type) KEY_TYPE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$KEY_PATH" ]]; then
  echo "Error: --key-path is required." >&2
  usage
  exit 1
fi

mkdir -p "$(dirname "$KEY_PATH")"

if [[ -f "$KEY_PATH" || -f "${KEY_PATH}.pub" ]]; then
  echo "Error: key path already exists: $KEY_PATH" >&2
  exit 1
fi

ssh-keygen -t "$KEY_TYPE" -C "$KEY_COMMENT" -f "$KEY_PATH" -N ""
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo "Created:"
echo "  Private key: $KEY_PATH"
echo "  Public key:  ${KEY_PATH}.pub"
