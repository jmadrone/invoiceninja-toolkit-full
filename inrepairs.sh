#!/bin/bash
IN_DIR="/var/www/invoiceninja"
WEB_USER="www-data"
LOG="/opt/invoiceninja-toolkit/logs/inrepairs.log"

echo "🔧 Running Invoice Ninja Repair: $(date)" | tee -a "$LOG"

if [ ! -d "$IN_DIR" ]; then
    echo "❌ ERROR: Invoice Ninja directory not found!" | tee -a "$LOG"
    exit 1
fi

echo "👉 Fixing ownership..." | tee -a "$LOG"
chown -R $WEB_USER:$WEB_USER "$IN_DIR"

echo "👉 Fixing file/dir permissions..." | tee -a "$LOG"
find "$IN_DIR" -type f -exec chmod 644 {} \;
find "$IN_DIR" -type d -exec chmod 755 {} \;

echo "👉 Setting writable permissions..." | tee -a "$LOG"
chmod -R 775 "$IN_DIR/storage" "$IN_DIR/bootstrap/cache"
setfacl -Rm u:$WEB_USER:rwx "$IN_DIR/storage" "$IN_DIR/bootstrap/cache" >/dev/null 2>&1

echo "👉 Securing .env..." | tee -a "$LOG"
if [ -f "$IN_DIR/.env" ]; then
    chmod 640 "$IN_DIR/.env"
    chown $WEB_USER:$WEB_USER "$IN_DIR/.env"
fi

echo "👉 Clearing Laravel caches..." | tee -a "$LOG"
/usr/bin/php "$IN_DIR/artisan" optimize:clear

echo "🚀 Repair completed!" | tee -a "$LOG"
