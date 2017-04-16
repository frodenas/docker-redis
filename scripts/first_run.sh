#!/bin/bash
PASS=${REDIS_PASSWORD:-$(pwgen -s -1 16)}

echo First run of Redis, setting up users...

mkdir -p /config
echo "{\"hosthame\":\"localhost\",\"host\":\"localhost\",\"port\":6379,\"password\":\"$PASS\"}" > /config/credentials.json
echo /config/credentials.json

echo "Securing Redis with a password..."
echo "requirepass $PASS" >> /etc/redis/redis.conf

echo "========================================================================"
echo "Redis Password: \"$PASS\""
echo "========================================================================"

rm -f /.firstrun
