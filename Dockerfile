ARG PYTHON_VERSION=3.10
# Build stage
FROM ghcr.io/astral-sh/uv:python${PYTHON_VERSION}-bookworm-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

WORKDIR /build

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev

ADD . /build

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

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
