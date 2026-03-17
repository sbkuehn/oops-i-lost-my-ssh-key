#!/usr/bin/env bash
# Author: Shannon Eldridge-Kuehn
# Date: 2026-03-17

tar -czf ssh-backup.tar.gz ~/.ssh
gpg -c ssh-backup.tar.gz
rm ssh-backup.tar.gz
