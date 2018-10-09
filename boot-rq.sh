#!/bin/sh

# this script is used to boot a Docker container
source venv/bin/activate

while true; do
    rq info --url "$REDIS_URL"
    if [[ $? == 0 ]]; then
        break
    fi
    echo 'rq command failed, retrying in 5 secs...'
    sleep 5
done

exec rq worker --url "$REDIS_URL" microblog
