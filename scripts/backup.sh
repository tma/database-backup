#!/bin/bash
set -e

# Run WAL-G backup commands
if [ -n "$MYSQL_HOST" ]; then
    export WALG_STREAM_CREATE_COMMAND="mysqldump -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --single-transaction ${MYSQL_DATABASE}"
    export WALG_MYSQL_DATASOURCE_NAME="${MYSQL_USER}:${MYSQL_PASSWORD}@tcp(${MYSQL_HOST}:${MYSQL_PORT:-3306})/${MYSQL_DATABASE}"
    /usr/local/bin/wal-g-mysql backup-push
    /usr/local/bin/wal-g-mysql delete retain FULL 1 --confirm
elif [ -n "$PGHOST" ]; then
    /usr/local/bin/wal-g-pg backup-push /var/lib/postgresql/data
    /usr/local/bin/wal-g-pg delete retain FULL 1 --confirm
else
    echo "No MySQL or PostgreSQL environment variables found"
fi

# Clean up empty folders in backup directory
find ${WALG_FILE_PREFIX} -type d -empty -delete

echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed, empty folders removed"
