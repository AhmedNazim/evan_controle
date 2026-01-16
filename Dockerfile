# Utiliser une image légère de base
FROM jenkins/agent:latest-jdk17

USER root

# Mettre à jour et installer les dépendances
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    python3 \
    python3-pip \
    wget \
    bash \
    gnupg \
    software-properties-common \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Installer Terraform
# -----------------------------

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
       > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get install -y terraform

# -----------------------------
# Installer Checkov
# -----------------------------

RUN pip3 install --break-system-packages --no-cache-dir checkov

# -----------------------------
# Installer TFLint
# -----------------------------

RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

USER jenkins

# -----------------------------
# Définir le répertoire de travail
# -----------------------------