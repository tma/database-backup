#!/bin/bash
set -e

# Generate environment script at runtime to capture passed ENV variables
echo "#!/bin/sh" > /app/wal-g-environment.sh
env | grep -E "^(WALG_|PG|MYSQL_)" | while IFS= read -r line; do
  echo "export $line" >> /app/wal-g-environment.sh
done
chmod +x /app/wal-g-environment.sh

# Setup cron job at runtime
echo "${CRON_SCHEDULE} . /app/wal-g-environment.sh && /app/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/wal-g-backup
chmod 0644 /etc/cron.d/wal-g-backup
crontab /etc/cron.d/wal-g-backup
touch /var/log/cron.log

# Initial output
echo "========================================"
echo "Database Backup"
echo "Started at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Scheduled backup: ${CRON_SCHEDULE}"
echo "========================================"

# Start cron and tail logs
cron
tail -f /var/log/cron.log
