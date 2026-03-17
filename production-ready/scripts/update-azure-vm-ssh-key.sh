#!/usr/bin/env bash
az vm user update --resource-group "$1" --name "$2" --username "$3" --ssh-key-value @"$4"
