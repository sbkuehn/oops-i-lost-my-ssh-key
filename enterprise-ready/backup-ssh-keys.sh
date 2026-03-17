#!/usr/bin/env bash
# ==============================================================================
# Create an encrypted backup archive of local SSH keys
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  backup-ssh-keys.sh --source-dir <dir> --output-prefix <prefix>

Options:
  --source-dir      Source SSH directory, usually ~/.ssh
  --output-prefix   Output archive prefix without extension
  -h, --help        Show this help message
EOF
}

SOURCE_DIR=""
OUTPUT_PREFIX=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source-dir) SOURCE_DIR="${2:-}"; shift 2 ;;
    --output-prefix) OUTPUT_PREFIX="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$SOURCE_DIR" || -z "$OUTPUT_PREFIX" ]]; then
  echo "Error: both --source-dir and --output-prefix are required." >&2
  usage
  exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: source directory not found: $SOURCE_DIR" >&2
  exit 1
fi

if ! command -v gpg >/dev/null 2>&1; then
  echo "Error: gpg is required for encrypted backups." >&2
  exit 1
fi

ARCHIVE_NAME="${OUTPUT_PREFIX}.tar.gz"
ENCRYPTED_ARCHIVE="${ARCHIVE_NAME}.gpg"

echo "Creating tar archive from $SOURCE_DIR ..."
tar -czf "$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

echo "Encrypting archive with gpg ..."
gpg -c "$ARCHIVE_NAME"

rm -f "$ARCHIVE_NAME"

echo "Encrypted backup created: $ENCRYPTED_ARCHIVE"
