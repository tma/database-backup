FROM debian:bookworm-slim

ENV WALG_FILE_PREFIX=/backups \
    CRON_SCHEDULE="0 * * * *"

WORKDIR /app

COPY scripts/install.sh /app/
COPY scripts/entrypoint.sh /app/
COPY scripts/backup.sh /app/

RUN chmod +x /app/*.sh
RUN /app/install.sh

VOLUME ["/var/lib/postgresql/data", "/backups"]

CMD ["/app/entrypoint.sh"]
