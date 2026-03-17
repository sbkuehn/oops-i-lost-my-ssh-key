#!/usr/bin/env bash
# ==============================================================================
# Quick script to generate a new SSH key
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

KEY_PATH="${1:-$HOME/.ssh/azure-ts-router}"
COMMENT="${2:-azure-router}"

mkdir -p "$(dirname "$KEY_PATH")"
ssh-keygen -t ed25519 -C "$COMMENT" -f "$KEY_PATH" -N ""
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo "Created $KEY_PATH and ${KEY_PATH}.pub"
