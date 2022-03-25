# Base image
FROM python:3.10.4-alpine

# Update packages
RUN apk upgrade --no-cache

# Workspace
WORKDIR /workspace

# Install dependencies
RUN apk add --no-cache \
    bash \
    build-base \
    cargo \
    curl \
    git \
    libffi-dev \
    openssh \
    openssl \
    openssl-dev \
    python3-dev

# Upgrade pip
RUN pip install --upgrade pip

# Install pip dependencies
ADD requirements.txt /workspace/
RUN pip install --requirement /workspace/requirements.txt

# Install ansible dependencies
ADD requirements.yaml /workspace/
RUN ansible-galaxy install --role-file /workspace/requirements.yaml
