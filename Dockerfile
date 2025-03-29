ARG PYTHON_VERSION=3.13
# Build stage
FROM ghcr.io/astral-sh/uv:python${PYTHON_VERSION}-bookworm-slim AS builder

WORKDIR /build

COPY uv.lock pyproject.toml ./
RUN uv sync --frozen --no-install-project --no-dev

ADD . /build

RUN uv sync --frozen --no-dev

# Final stage
FROM python:${PYTHON_VERSION}-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN useradd -ms /bin/bash app

COPY --from=builder --chown=app:app /build/docker-entrypoint.sh /usr/local/bin/
COPY --from=builder --chown=app:app /build /app

ENV PATH="/app/.venv/bin:$PATH"

USER app

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["app.main"]
