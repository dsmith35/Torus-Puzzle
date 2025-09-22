#!/bin/bash
# Stop on error but continue to log
set -e

echo "=== STARTUP SCRIPT ==="
echo "PORT=$PORT"

# Optional: keep alive for debugging
# echo "Sleeping 300s to debug..."
# sleep 300

echo "=== Collecting static files ==="
if python Qbackend/manage.py collectstatic --noinput; then
    echo "Collectstatic completed ✅"
else
    echo "Collectstatic failed ❌"
fi

echo "=== Applying migrations ==="
if python Qbackend/manage.py migrate; then
    echo "Migrations applied ✅"
else
    echo "Migrations failed ❌"
fi

echo "=== Starting Gunicorn ==="
exec gunicorn Qbackend.wsgi:application \
    --bind=0.0.0.0:$PORT \
    --log-level=debug \
    --access-logfile - \
    --error-logfile -
