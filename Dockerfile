FROM python:3.11-buster

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

WORKDIR /app
