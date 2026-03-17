# Quick Fix Version

Author: Shannon Eldridge-Kuehn  
Date: 2026-03-17

## What this is

This is the fastest way to recover SSH access to an Azure VM.

No abstraction. No ceremony.

## Steps

### 1. Generate a key

```bash
./generate-key.sh
```

### 2. Update your VM

Edit:

```bash
update-vm-key.sh
```

Then run:

```bash
./update-vm-key.sh
```

### 3. Connect

```bash
ssh -i ~/.ssh/azure-ts-router azureuser@<private-ip>
```

## Optional backup

```bash
./backup-keys.sh
```
