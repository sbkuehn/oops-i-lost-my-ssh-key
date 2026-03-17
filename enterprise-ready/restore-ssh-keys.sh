#!/usr/bin/env bash
# ==============================================================================
# Restore an encrypted SSH key backup archive
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  restore-ssh-keys.sh --archive <file.tar.gz.gpg> --destination <dir>

Options:
  --archive       Encrypted archive file
  --destination   Directory to restore into, usually ~/.ssh
  -h, --help      Show this help message
EOF
}

ARCHIVE=""
DESTINATION=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --archive) ARCHIVE="${2:-}"; shift 2 ;;
    --destination) DESTINATION="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$ARCHIVE" || -z "$DESTINATION" ]]; then
  echo "Error: both --archive and --destination are required." >&2
  usage
  exit 1
fi

if [[ ! -f "$ARCHIVE" ]]; then
  echo "Error: archive not found: $ARCHIVE" >&2
  exit 1
fi

TMP_ARCHIVE="${ARCHIVE%.gpg}"

mkdir -p "$(dirname "$DESTINATION")"

echo "Decrypting archive ..."
gpg -d "$ARCHIVE" > "$TMP_ARCHIVE"

echo "Restoring files to $(dirname "$DESTINATION") ..."
tar -xzf "$TMP_ARCHIVE" -C "$(dirname "$DESTINATION")"

rm -f "$TMP_ARCHIVE"

if [[ -d "$DESTINATION" ]]; then
  chmod 700 "$DESTINATION" || true
fi

echo "Restore completed successfully."
