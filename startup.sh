#!/bin/bash

# Install Python dependencies
pip install -r requirements.txt

# Install Node.js dependencies and build frontend
cd frontend
npm install
npm run build
cd ..

# Collect static files
python Qbackend/manage.py collectstatic --noinput

# Run Django server (Azure will use Gunicorn in production)
python Qbackend/manage.py runserver 0.0.0.0:8000
