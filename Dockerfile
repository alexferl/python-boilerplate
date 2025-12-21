ARG PYTHON_VERSION=3.14
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

RUN groupadd -g 65532 nonroot && \
    useradd -u 65532 -g 65532 -s /usr/sbin/nologin -m nonroot

COPY --from=builder --chown=nonroot:nonroot /build/docker-entrypoint.sh /usr/local/bin/
COPY --from=builder --chown=nonroot:nonroot /build /app

ENV PATH="/app/.venv/bin:$PATH"

USER nonroot

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["app.main"]
