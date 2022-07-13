#!/usr/bin/env bash
# shellcheck disable=SC3030,3028,3054,3020,3010,3024,3040

sudo apt-get update
sudo apt-get install \
  --yes \
  'xz-utils'
  
sh <(curl -L https://nixos.org/nix/install) --no-daemon

sudo rm -rf /var/lib/apt/lists/*
