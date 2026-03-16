#!/bin/bash

# 1. Secure the Vault Directory (Phase 1)
# Gives owner full control (7), others nothing (0) 
chmod 700 ~/Vault

# 2. Secure the Secrets File (Phase 1)
# Gives owner read/write (6), others nothing (0) [cite: 23]
chmod 600 ~/Vault/secrets.txt

# 3. Secure the System Shadow File (Phase 2)
# Restores security to the identity file [cite: 29, 30]
sudo chmod 640 /etc/shadow
sudo chown root:shadow /etc/shadow
