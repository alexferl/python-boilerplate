ARG PYTHON_VERSION=3.10.0
FROM python:${PYTHON_VERSION}-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /build
COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /build/wheels -r requirements.txt

FROM python:${PYTHON_VERSION}-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100

WORKDIR /app

RUN useradd -ms /bin/bash appuser

COPY --from=builder /build/wheels /wheels
COPY --chown=appuser:appuser docker-entrypoint.sh /usr/local/bin/

RUN pip install --no-cache /wheels/* \
    && rm -rf /wheels \
    && rm -rf /root/.cache/pip/*

COPY . .

RUN chown -R appuser:appuser /app

USER appuser

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["main"]
