#!/bin/sh
set -e

mkdir -p /data/.openclaw
chown -R node:node /data
chmod 755 /data
chmod 777 /data/.openclaw

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

exec gosu node "$@"
