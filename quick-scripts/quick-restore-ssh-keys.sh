#!/usr/bin/env bash
# ==============================================================================
# Quick script to restore an encrypted SSH key backup
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

ARCHIVE="${1:-ssh-keys-backup.tar.gz.gpg}"
DESTINATION="${2:-$HOME/.ssh}"

TMP_ARCHIVE="${ARCHIVE%.gpg}"
mkdir -p "$(dirname "$DESTINATION")"
gpg -d "$ARCHIVE" > "$TMP_ARCHIVE"
tar -xzf "$TMP_ARCHIVE" -C "$(dirname "$DESTINATION")"
rm -f "$TMP_ARCHIVE"

echo "Restored archive into $(dirname "$DESTINATION")"
