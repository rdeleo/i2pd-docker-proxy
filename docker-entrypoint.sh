#!/bin/sh
set -e

# Ensure data directory has correct ownership
# This handles the case where a Docker volume is mounted
if [ "$(id -u)" = "0" ]; then
    # Running as root, fix permissions and switch to i2pd user
    chown -R i2pd:i2pd /home/i2pd/data
    
    # Create certificates symlinks if they don't exist
    mkdir -p /home/i2pd/data/certificates
    [ -L /home/i2pd/data/certificates/family ] || ln -sf /usr/share/i2pd/certificates/family /home/i2pd/data/certificates/family
    [ -L /home/i2pd/data/certificates/reseed ] || ln -sf /usr/share/i2pd/certificates/reseed /home/i2pd/data/certificates/reseed
    
    # Switch to i2pd user and execute i2pd
    exec gosu i2pd i2pd "$@"
else
    # Already running as non-root user
    if [ ! -w "/home/i2pd/data" ]; then
        echo "Warning: /home/i2pd/data is not writable. Please ensure the volume has correct permissions."
    fi
    
    # Create certificates symlinks if they don't exist
    mkdir -p /home/i2pd/data/certificates
    [ -L /home/i2pd/data/certificates/family ] || ln -sf /usr/share/i2pd/certificates/family /home/i2pd/data/certificates/family
    [ -L /home/i2pd/data/certificates/reseed ] || ln -sf /usr/share/i2pd/certificates/reseed /home/i2pd/data/certificates/reseed
    
    exec i2pd "$@"
fi
