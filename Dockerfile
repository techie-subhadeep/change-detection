FROM python:3.11-buster

# ================= ODBC Setup ===============================
RUN apt-get update \
    && apt-get install -y gnupg2 curl \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev
# ============================================================

# ================= Poetry Installation =======================
ENV POETRY_VERSION=1.5.0 
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false
# =============================================================

# ================= Python Dependency Installation ==============
COPY ./pyproject.toml ./poetry.lock* /tmp/
RUN cd /tmp && poetry install --no-root
# ==============================================================

# ================= Install Hasura CLI =========================
RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
# ==============================================================

WORKDIR /app
