#!/usr/bin/env bash
# ==============================================================================
# Quick script to update an Azure VM user with a new SSH key
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

RG="${1:-sbkWusHub}"
VM_NAME="${2:-sbk-wus-ts-router01}"
USERNAME="${3:-azureuser}"
PUBLIC_KEY="${4:-$HOME/.ssh/azure-ts-router.pub}"

az vm user update \
  --resource-group "$RG" \
  --name "$VM_NAME" \
  --username "$USERNAME" \
  --ssh-key-value @"$PUBLIC_KEY"

echo "Public key injected into $VM_NAME"
