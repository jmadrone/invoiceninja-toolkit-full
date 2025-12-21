#!/bin/bash
TOOLKIT_DIR="/opt/invoiceninja-toolkit"
BIN_DIR="/usr/local/bin"

echo "🔧 Installing Invoice Ninja Toolkit..."

chmod -R 755 $TOOLKIT_DIR/*.sh
mkdir -p $TOOLKIT_DIR/logs

ln -sf "$TOOLKIT_DIR/inrepairs.sh"        "$BIN_DIR/inrepairs"
ln -sf "$TOOLKIT_DIR/inaudit.sh"          "$BIN_DIR/inaudit"
ln -sf "$TOOLKIT_DIR/inbackup.sh"         "$BIN_DIR/inbackup"
ln -sf "$TOOLKIT_DIR/inrestore.sh"        "$BIN_DIR/inrestore"
ln -sf "$TOOLKIT_DIR/in-supervisor-heal.sh" "$BIN_DIR/inhealsupervisor"

cp $TOOLKIT_DIR/systemd/invoiceninja-scheduler.service /etc/systemd/system/
cp $TOOLKIT_DIR/systemd/invoiceninja-scheduler.timer   /etc/systemd/system/

systemctl daemon-reload
systemctl enable --now invoiceninja-scheduler.timer

echo "🎉 Toolkit installed successfully."
echo "Commands available: inrepairs, inaudit, inbackup, inrestore, inhealsupervisor"
