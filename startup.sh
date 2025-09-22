#!/bin/bash

# 1. Build React frontend
echo "Building React frontend..."
cd frontend
npm install --legacy-peer-deps
npm run build
cd ..

# 2. Collect static files for Django
echo "Collecting Django static files..."
python Qbackend/manage.py collectstatic --noinput

# 3. Apply migrations (optional but recommended)
echo "Applying Django migrations..."
python Qbackend/manage.py migrate

# 4. Run Django backend with Gunicorn
echo "Starting Django server..."
gunicorn Qbackend.wsgi:application --bind 0.0.0.0:${PORT:-8000}
