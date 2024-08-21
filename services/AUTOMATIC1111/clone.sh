#!/bin/bash

set -Eeuox pipefail
git config --global http.postBuffer 1048576000
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999

MAX_ATTEMPTS=5
COUNT=0

until git clone "$2" /repositories/"$1" || [ $COUNT -eq $MAX_ATTEMPTS ]; do
    COUNT=$((COUNT+1))
    echo "Retrying clone ($COUNT/$MAX_ATTEMPTS)..."
done

cd /repositories/"$1"
git reset --hard "$3"
rm -rf .git
