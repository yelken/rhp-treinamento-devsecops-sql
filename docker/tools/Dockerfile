FROM python:3.11-slim

ENV PIP_DISABLE_PIP_VERSION_CHECK=on \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates gnupg \
    postgresql-client \
 && rm -rf /var/lib/apt/lists/*

# sqlfluff
RUN pip install --no-cache-dir sqlfluff==3.1.0

# gitleaks
ARG GITLEAKS_VERSION=8.18.4
RUN curl -sSL https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz \
  | tar -xz && mv gitleaks /usr/local/bin/gitleaks

WORKDIR /work


