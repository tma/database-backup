#!/bin/bash
set -e

# Install dependencies & WAL-G
apt-get update && apt-get install -y --no-install-recommends \
  wget \
  cron \
  postgresql-client \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Download and install WAL-G
ARCH=$(dpkg --print-architecture)
WALG_VERSION="v3.0.7"

wget -qO /tmp/wal-g.tar.gz "https://github.com/wal-g/wal-g/releases/download/${WALG_VERSION}/wal-g-pg-ubuntu-22.04-${ARCH}.tar.gz"
tar -xzf /tmp/wal-g.tar.gz -C /usr/local/bin/
mv /usr/local/bin/wal-g-pg-ubuntu-22.04-* /usr/local/bin/wal-g
chmod +x /usr/local/bin/wal-g
rm /tmp/wal-g.tar.gz
