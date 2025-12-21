# Invoice Ninja Toolkit

This toolkit provides automated maintenance, auditing, repair, backup, and restore tools for a self-hosted Invoice Ninja v5 installation.

## Included Commands
- inrepairs — Fix permissions and caches
- inaudit — Audit installation health
- inbackup — Create full backup (files + DB)
- inrestore — Restore from backup
- inhealsupervisor — Auto-heal queue workers

## Installation
sudo bash /opt/invoiceninja-toolkit/install_toolkit.sh

## Systemd Scheduler
Replaces the default cron approach with a reliable timer.
