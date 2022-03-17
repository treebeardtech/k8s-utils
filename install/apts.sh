#!/usr/bin/env bash
# shellcheck disable=SC3030,3028,3054,3020,3010,3024,3040

sudo apt-get update
sudo apt-get install \
  --yes \
  'xz-utils'
sudo apt-get install \
  --no-install-recommends \
  --yes \
  'python3-pip'
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
