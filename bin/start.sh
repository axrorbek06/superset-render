#!/bin/sh
set -eu

/app/.venv/bin/superset db upgrade

/app/.venv/bin/superset fab create-admin \
  --username "${SUPERSET_ADMIN_USERNAME}" \
  --firstname "${SUPERSET_ADMIN_FIRSTNAME:-Codex}" \
  --lastname "${SUPERSET_ADMIN_LASTNAME:-Admin}" \
  --email "${SUPERSET_ADMIN_EMAIL}" \
  --password "${SUPERSET_ADMIN_PASSWORD}" || true

/app/.venv/bin/superset init

exec /app/.venv/bin/gunicorn \
  --bind "0.0.0.0:${SUPERSET_PORT:-8088}" \
  --workers "${GUNICORN_WORKERS:-1}" \
  --threads 8 \
  --timeout 120 \
  "superset.app:create_app()"
