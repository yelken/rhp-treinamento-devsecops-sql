FROM python:3.11-slim

ENV PIP_DISABLE_PIP_VERSION_CHECK=on \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates gnupg \
    postgresql-client \
 && rm -rf /var/lib/apt/lists/*

# (Opcional) Confiar em CAs corporativas: coloque .crt(s) em docker/tools/certs/
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates || true
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# sqlfluff (com fallback para ambiente corporativo sem cadeia completa)
RUN pip config set global.trusted-host "pypi.org files.pythonhosted.org" && \
    pip install --no-cache-dir sqlfluff==3.1.0

# gitleaks (com fallback -k para ambientes com interceptação TLS)
ARG GITLEAKS_VERSION=8.18.4
RUN curl -fsSLk https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz \
  | tar -xz && mv gitleaks /usr/local/bin/gitleaks

WORKDIR /work


