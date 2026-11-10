#!/bin/sh
PORT="${PORT:-3000}"
sed -i "s/\"port\": [0-9]*/\"port\": ${PORT}/g" /etc/xray/config.json
echo "Starting Xray on port ${PORT}..."
exec xray run -c /etc/xray/config.json
