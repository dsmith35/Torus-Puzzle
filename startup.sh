#!/bin/bash
pip install --upgrade pip
pip install -r requirements.txt
gunicorn Qbackend.wsgi:application --chdir Qbackend --bind 0.0.0.0:8000