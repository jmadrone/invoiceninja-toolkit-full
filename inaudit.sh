#!/bin/bash
IN_DIR="/var/www/invoiceninja"
WEB_USER="www-data"

echo "🔍 Invoice Ninja Audit — $(date)"
echo

if [ ! -d "$IN_DIR" ]; then
    echo "❌ ERROR: Invoice Ninja directory not found!"
    exit 1
fi

echo "📁 Checking ownership..."
BAD=$(find "$IN_DIR" ! -user $WEB_USER -o ! -group $WEB_USER | head -n 20)
[ -z "$BAD" ] && echo "✅ Ownership OK" || echo "❌ Ownership issues:" && echo "$BAD"
echo

echo "🔐 Checking permissions..."
BAD_F=$(find "$IN_DIR" -type f ! -perm 644 | head -n 20)
BAD_D=$(find "$IN_DIR" -type d ! -perm 755 | head -n 20)
[ -z "$BAD_F" ] && echo "✅ File perms OK" || echo "$BAD_F"
[ -z "$BAD_D" ] && echo "✅ Dir perms OK" || echo "$BAD_D"
echo

echo "📝 Checking writable dirs..."
for d in storage bootstrap/cache; do
    if sudo -u $WEB_USER test -w "$IN_DIR/$d"; then
        echo "✅ $d writable"
    else
        echo "❌ $d NOT writable"
    fi
done
echo

echo "🔐 Checking .env..."
if [ -f "$IN_DIR/.env" ]; then
    PERMS=$(stat -c "%a" "$IN_DIR/.env")
    [[ "$PERMS" == "640" ]] && echo "✅ .env OK" || echo "❌ .env perms wrong ($PERMS)"
else
    echo "❌ .env missing!"
fi
echo

echo "🚦 Checking queue workers..."
if systemctl is-active --quiet supervisor; then
    supervisorctl status | grep invoiceninja-worker || echo "❌ No worker found"
else
    echo "❌ Supervisor not running."
fi

echo
echo "📊 Audit complete."
