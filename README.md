# Invoice Ninja Toolkit

This toolkit provides automated maintenance, auditing, repair, backup, and restore tools for a self-hosted Invoice Ninja v5 installation.

## Pre-Requisites

- Deabian 12 / Ubuntu 22.04 (Tested)
- PHP (Laravel)
- MariaDB / MySQL
- Nginx
- Supervisor (Manage Queues with Supervisor rather than Cron)

### Environment

- Webroot: `/var/www/invoiceninja`
- User: `www-data` (Nginx default)
- System scheduler: `Systemd` (better than cron)
- SSL/TLS certs issued from LetsEncrypt with `acme.sh`, utilizing DNS API for challenge, as opposed to `Certbot`'s default webroot method which requires port 80 to be open.
- Firewall: `ufw` (uncomplicated firewall)
- Intrusion Prevension Tool: `fail2ban`

## Included Commands

- `inrepairs` — Fix permissions and caches
- `inaudit` — Audit installation health
- `inbackup` — Create full backup (files + DB)
- `inrestore` — Restore from backup
- `inhealsupervisor` — Auto-heal queue workers

## Installation

```bash
sudo bash /opt/invoiceninja-toolkit/install_toolkit.sh
```

## Systemd Scheduler

Replaces the default `cron` approach with a reliable timer.
