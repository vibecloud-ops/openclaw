#!/bin/sh
set -e

# Ensure /data and /data/.openclaw exist with correct ownership and permissions.
# This must run as root at container startup, after the volume is mounted,
# because Railway mounts the persistent volume at /data at runtime and
# overwrites any permissions set during the Docker build.
mkdir -p /data/.openclaw
chown -R node:node /data
chmod 755 /data
chmod 777 /data/.openclaw

# Drop privileges and exec the original command as the node user
exec gosu node "$@"
