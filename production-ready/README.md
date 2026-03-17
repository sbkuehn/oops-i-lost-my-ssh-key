# Production Ready Version

Author: Shannon Eldridge-Kuehn  
Date: 2026-03-17

## What this is

A slightly more structured version of the same workflow.

Includes:

- reusable scripts
- parameter support
- safer execution patterns

## Example

```bash
./scripts/generate-ssh-key.sh ~/.ssh/azure-ts-router
./scripts/update-azure-vm-ssh-key.sh sbkWusHub sbk-wus-ts-router01 azureuser ~/.ssh/azure-ts-router.pub
```
