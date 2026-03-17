#!/usr/bin/env bash
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17

RG="your-resource-group"
VM_NAME="your-vm-name"
USERNAME="azureuser"
PUBLIC_KEY="$HOME/.ssh/azure-ts-router.pub"

az vm user update \
  --resource-group "$RG" \
  --name "$VM_NAME" \
  --username "$USERNAME" \
  --ssh-key-value @"$PUBLIC_KEY"
