#!/bin/bash

export PROXY_READ_TIMEOUT=${PROXY_READ_TIMEOUT:-240}

# Replace env vars
envsubst "$(printf '${%s} ' $(bash -c "compgen -A variable"))" < /templates/all.template > /run/default.conf

# RegEx
REGEX="^(/v[\\d\\.]+)?(/\\w+)?"
sed -i "s|#!REGEX|${REGEX}|g" /run/default.conf

# IPv6
if [[ -z "$DISABLE_IPV6" || "$DISABLE_IPV6" == 0 ]]; then
    sed -i "s|#!ALLOW_IPV6||" /run/default.conf
fi

# Methods
METHODS="GET HEAD"
if [[ $POST == 1 ]]; then
    METHODS="$METHODS POST"
fi
sed -i "s|#!LIMIT_METHODS|${METHODS}|g" /run/default.conf

mkdir /run/nginx-tmp

echo '
──────────────────────────────────────────────
Based on the image provided by linuxserver.io
──────────────────────────────────────────────

To support LSIO projects visit:
https://www.linuxserver.io/donate/

──────────────────────────────────────────────'

echo "[ls.io-init] done."

exec /usr/sbin/nginx -e stderr
