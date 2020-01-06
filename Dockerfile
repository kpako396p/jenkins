FROM nginx:latest
RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*
COPY . /usr/share/nginx/html