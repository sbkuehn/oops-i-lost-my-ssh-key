#!/usr/bin/env bash
# ==============================================================================
# Quick script to create an encrypted SSH key backup
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

SOURCE_DIR="${1:-$HOME/.ssh}"
OUTPUT_PREFIX="${2:-ssh-keys-backup}"

ARCHIVE_NAME="${OUTPUT_PREFIX}.tar.gz"

tar -czf "$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"
gpg -c "$ARCHIVE_NAME"
rm -f "$ARCHIVE_NAME"

echo "Created encrypted backup: ${ARCHIVE_NAME}.gpg"
