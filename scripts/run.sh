#!/bin/bash

# Initialize first run
if [[ -e /.firstrun ]]; then
    /scripts/first_run.sh
fi

# Start Redis
echo "Starting Redis..."
/usr/local/bin/redis-server /etc/redis/redis.conf $@
