#!/bin/sh
set -eu

exec /app/.venv/bin/gunicorn \
  --bind "0.0.0.0:${SUPERSET_PORT:-8088}" \
  --workers "${GUNICORN_WORKERS:-1}" \
  --threads 8 \
  --timeout 120 \
  "superset.app:create_app()"
