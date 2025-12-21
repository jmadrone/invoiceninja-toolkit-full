#!/bin/bash
BACKUP_DIR="$1"
IN_DIR="/var/www/invoiceninja"

if [ -z "$BACKUP_DIR" ]; then
    echo "Usage: inrestore /path/to/backup"
    exit 1
fi

echo "⚠️ Restoring from $BACKUP_DIR ..."

systemctl stop php*-fpm
systemctl stop nginx

tar -xzf "$BACKUP_DIR/invoiceninja-files.tar.gz" -C /
mysql -u root invoiceninja < "$BACKUP_DIR/db.sql"

echo "🔧 Running repairs..."
inrepairs

systemctl start php*-fpm
systemctl start nginx

echo "🎉 Restore complete."
