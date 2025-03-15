# Dockerfile для бэкенда
# docker/Dockerfile
FROM python:3.10-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Установка системных зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Установка зависимостей Python
COPY backend/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Копирование проекта
COPY backend/ /app/

# Предоставление прав на исполнение скриптов
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

# Dockerfile для фронтенда
# docker/Dockerfile.frontend
FROM node:16-alpine

WORKDIR /app

COPY frontend/package.json frontend/package-lock.json* ./

RUN npm install

COPY frontend/ ./

CMD ["npm", "start"]
