#!/bin/bash
PASS=${REDIS_PASSWORD:-$(pwgen -s -1 16)}

echo "Securing Redis with a password..."
echo "requirepass $PASS" >> /etc/redis/redis.conf

echo "========================================================================"
echo "Redis Password: \"$PASS\""
echo "========================================================================"

rm -f /.firstrun
