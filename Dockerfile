# Stage 1: Build frontend
FROM node:latest AS frontend

# Set working directory for frontend
WORKDIR /app/frontend

# Copy frontend source code
COPY frontend/package.json frontend/package-lock.json ./
COPY frontend .

# Install dependencies
RUN npm install

# Stage 2: Build backend
FROM python:3.9-slim AS backend

# Set working directory for backend
WORKDIR /app/backend

# Install backend dependencies
COPY backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Bundle app source
COPY . /app

EXPOSE 8080

# Start gunicorn server for backend
CMD [ "python", "backend/app.py" ]
