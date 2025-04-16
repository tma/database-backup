# PostgreSQL Backup Service

Automated PostgreSQL database backup solution using WAL-G.

## Usage

```yaml
version: '3'
services:
  backup:
    build: .
    environment:
      WALG_FILE_PREFIX: /backups
      PGHOST: database
      PGPORT: 5432
      PGUSER: postgres
      PGPASSWORD: password
      PGDATABASE: mydb
      CRON_SCHEDULE: "0 * * * *"
    volumes:
      - db-data:/var/lib/postgresql/data:ro
      - backups:/backups

volumes:
  db-data:
    external: true
  backups:
```

## Environment Variables

- `WALG_FILE_PREFIX`: Backup storage location
- `PGHOST`, `PGPORT`, `PGUSER`, `PGPASSWORD`, `PGDATABASE`: PostgreSQL connection details
- `CRON_SCHEDULE`: Backup frequency (cron format)

## Operation

Hourly backups by default, retaining only the latest full backup.
Empty directories are automatically cleaned up.
