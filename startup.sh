#!/bin/bash

# Go to backend folder
cd $HOME/site/wwwroot/Qbackend

# Activate virtualenv if exists
if [ -f antenv/bin/activate ]; then
    source antenv/bin/activate
fi

# 1. Build React frontend
echo "Building React frontend..."
cd ../frontend
npm install --legacy-peer-deps
npm run build
cd ../Qbackend

# 2. Collect Django static files
echo "Collecting Django static files..."
python manage.py collectstatic --noinput

# 3. Apply migrations
echo "Applying Django migrations..."
python manage.py migrate

# 4. Start Django via Gunicorn
echo "Starting Django server..."
gunicorn Qbackend.wsgi:application --bind 0.0.0.0:$PORT
