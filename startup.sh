#!/bin/bash
set -e

echo "PORT=$PORT"

# Build frontend (optional, slow!)
# cd frontend
# npm install --legacy-peer-deps
# npm run build
# cd ..

echo "Collecting static..."
python Qbackend/manage.py collectstatic --noinput

echo "Applying migrations..."
python Qbackend/manage.py migrate

echo "Starting Gunicorn..."
exec gunicorn Qbackend.wsgi:application --bind=0.0.0.0:$PORT --log-level=debug

#A
