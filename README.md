# Azure VM SSH Key Recovery Toolkit

A GitHub-ready collection of scripts for recovering SSH access to Azure Linux VMs after moving to a new computer or losing the original private key.

Author: Shannon Eldridge-Kuehn  
Date: 2026-03-17

## What is in this repo

This repo includes two sets of scripts:

### Enterprise-ready
These scripts include:
- argument parsing
- usage help
- guardrails and validation
- safer defaults
- clearer output

### Quick scripts
These are streamlined examples for fast copy/paste usage.

## Folder structure

```text
.
├── README.md
├── LICENSE
├── .gitignore
├── enterprise-ready
│   ├── backup-ssh-keys.sh
│   ├── generate-ssh-key.sh
│   ├── restore-ssh-keys.sh
│   └── update-azure-vm-ssh-key.sh
├── quick-scripts
│   ├── quick-backup-ssh-keys.sh
│   ├── quick-generate-ssh-key.sh
│   ├── quick-restore-ssh-keys.sh
│   └── quick-update-azure-vm-ssh-key.sh
└── examples
    └── env.example
```

## Common use case

You have an Azure VM already running, you moved to a new computer, and the original private SSH key is gone. Azure does not store your private key, so the fix is to generate a new key locally and inject the new public key into the VM.

## Quick start

### 1. Generate a new key
```bash
./enterprise-ready/generate-ssh-key.sh \
  --key-path ~/.ssh/myVm \
  --comment "azure-router"
```

### 2. Inject the public key into the Azure VM
```bash
./enterprise-ready/update-azure-vm-ssh-key.sh \
  --resource-group myRg \
  --vm-name myVm \
  --username azureuser \
  --public-key ~/.ssh/myVm.pub
```

### 3. Test access
```bash
ssh -i ~/.ssh/myVm azureuser@10.10.1.5
```

## Back up your SSH keys

### Enterprise-ready backup
```bash
./enterprise-ready/backup-ssh-keys.sh \
  --source-dir ~/.ssh \
  --output-prefix ssh-keys-backup
```

### Quick backup
```bash
./quick-scripts/quick-backup-ssh-keys.sh
```

## Restore your SSH keys

### Enterprise-ready restore
```bash
./enterprise-ready/restore-ssh-keys.sh \
  --archive ssh-keys-backup.tar.gz.gpg \
  --destination ~/.ssh
```

### Quick restore
```bash
./quick-scripts/quick-restore-ssh-keys.sh
```

## Notes

- Azure does **not** store your private SSH key.
- Keep private keys out of Git.
- Use dedicated keys for dedicated environments.
- Encrypted backups make moving to a new machine much less painful.

## License

MIT
