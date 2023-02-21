#!/bin/bash
set -x
# https://developer.hashicorp.com/vault/docs/install
# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt install vault

vault --version

