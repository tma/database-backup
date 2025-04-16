#!/bin/bash
set -e

# Run WAL-G backup commands
/usr/local/bin/wal-g backup-push /var/lib/postgresql/data
/usr/local/bin/wal-g delete retain FULL 1 --confirm

# Clean up empty folders in backup directory
find ${WALG_FILE_PREFIX} -type d -empty -delete

echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed, empty folders removed"
