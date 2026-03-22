#!/bin/sh
set -e

# Ensure /data and /data/.openclaw exist with correct ownership and permissions.
mkdir -p /data/.openclaw
chown -R node:node /data
chmod 755 /data
chmod 777 /data/.openclaw

# Inject OpenClaw config if it doesn't exist yet
if [ ! -f /data/.openclaw/openclaw.json ]; then
  cat > /data/.openclaw/openclaw.json << 'CONFIGEOF'
{
  "gateway": {
    "controlUi": {
      "dangerouslyAllowHostHeaderOriginFallback": true,
      "allowedOrigins": ["*"]
    }
  }
}
CONFIGEOF
  chown node:node /data/.openclaw/openclaw.json
fi

# Drop privileges and exec the original command as the node user
exec gosu node "$@"
