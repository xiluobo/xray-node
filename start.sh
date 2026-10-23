#!/bin/sh
# xray VLESS + WebSocket inbound on $PORT (PaaS-assigned), UUID/WSPATH from env.
PORT_TO_USE=${PORT:-7860}
: "${UUID:?UUID env var required}"
WSPATH=${WSPATH:-ws}
cat > /usr/local/xray/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": ${PORT_TO_USE},
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "${UUID}", "flow": ""}],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {"path": "/${WSPATH}"}
      }
    }
  ],
  "outbounds": [{"protocol": "freedom", "tag": "direct"}]
}
EOF
exec /usr/local/xray/xray run -config /usr/local/xray/config.json
