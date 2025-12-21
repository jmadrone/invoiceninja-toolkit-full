#!/bin/bash
IN_DIR="/var/www/invoiceninja"
BACKUP_DIR="/opt/invoiceninja-toolkit/backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
DEST="$BACKUP_DIR/$DATE"
mkdir -p "$DEST"

echo "🔐 Creating Invoice Ninja backup..."

mysqldump -u root invoiceninja > "$DEST/db.sql"
tar -czf "$DEST/invoiceninja-files.tar.gz" "$IN_DIR"

echo "🧹 Pruning backups older than 14 days..."
find "$BACKUP_DIR" -maxdepth 1 -mtime +14 -type d -exec rm -rf {} \;

echo "🎉 Backup complete: $DEST"
