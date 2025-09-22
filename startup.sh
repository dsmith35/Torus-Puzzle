#!/bin/bash
set -e  # exit on first error
echo "Building frontend..."
cd frontend && npm install --legacy-peer-deps && npm run build
cd ..
echo "Collecting static..."
python Qbackend/manage.py collectstatic --noinput
echo "Applying migrations..."
python Qbackend/manage.py migrate
echo "Starting Gunicorn..."
exec gunicorn Qbackend.wsgi:application --bind=0.0.0.0:${PORT:-8000} --log-level=debug
