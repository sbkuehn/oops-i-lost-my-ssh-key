#!/usr/bin/env bash
tar -czf "$1".tar.gz "$2"
gpg -c "$1".tar.gz
