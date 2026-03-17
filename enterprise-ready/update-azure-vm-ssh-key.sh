#!/usr/bin/env bash
# ==============================================================================
# Inject a new public SSH key into an Azure Linux VM user account
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17
# ==============================================================================

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  update-azure-vm-ssh-key.sh --resource-group <rg> --vm-name <vm> --username <user> --public-key <path>
EOF
}

RG=""
VM_NAME=""
USERNAME=""
PUBLIC_KEY=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --resource-group) RG="${2:-}"; shift 2 ;;
    --vm-name) VM_NAME="${2:-}"; shift 2 ;;
    --username) USERNAME="${2:-}"; shift 2 ;;
    --public-key) PUBLIC_KEY="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$RG" || -z "$VM_NAME" || -z "$USERNAME" || -z "$PUBLIC_KEY" ]]; then
  echo "Error: all arguments are required." >&2
  usage
  exit 1
fi

if ! command -v az >/dev/null 2>&1; then
  echo "Error: Azure CLI not found in PATH." >&2
  exit 1
fi

if [[ ! -f "$PUBLIC_KEY" ]]; then
  echo "Error: public key file not found: $PUBLIC_KEY" >&2
  exit 1
fi

az vm user update \
  --resource-group "$RG" \
  --name "$VM_NAME" \
  --username "$USERNAME" \
  --ssh-key-value @"$PUBLIC_KEY"

echo "Public key injected successfully."
echo "Test with:"
echo "ssh -i ${PUBLIC_KEY%.pub} ${USERNAME}@<vm-private-or-tailscale-ip>"
