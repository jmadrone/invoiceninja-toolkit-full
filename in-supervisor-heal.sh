#!/bin/bash
if ! supervisorctl status | grep -q RUNNING; then
    echo "❌ Workers not running — restarting..."
    supervisorctl restart all
else
    echo "✅ Workers OK"
fi
