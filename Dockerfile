# Base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8000

# Set work directory
WORKDIR /app

# Install system dependencies (if needed)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy Python requirements first (for caching)
COPY Qbackend/requirements.txt /app/requirements.txt

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of your backend code
COPY Qbackend /app/Qbackend
COPY frontend /app/frontend

# Build React frontend
WORKDIR /app/frontend
RUN npm install --legacy-peer-deps
RUN npm run build

# Collect static files
WORKDIR /app
RUN python Qbackend/manage.py collectstatic --noinput

# Apply migrations (optional, sometimes done at startup)
# RUN python Qbackend/manage.py migrate

# Expose port
EXPOSE 8000

# Start Gunicorn
CMD ["gunicorn", "Qbackend.wsgi:application", "--bind", "0.0.0.0:8000", "--log-level", "debug"]
