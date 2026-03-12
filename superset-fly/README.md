# Superset On Fly.io

This is a production-leaning Superset deployment bundle meant to replace the unstable local Docker/WSL host.

## Why This Path

- your current Windows/WSL runtime is unstable
- the `superset-codex` client already works against a stable Superset API
- Fly.io gives us a Linux host for the app
- managed Postgres gives us a stable metadata database

## What This Bundle Assumes

- Fly.io hosts the Superset app
- a managed PostgreSQL instance is available
- the app receives its metadata DB connection through `DATABASE_URL`

## Required Fly Secrets

Set these before deploy:

```powershell
fly secrets set DATABASE_URL="postgresql+psycopg2://USER:PASSWORD@HOST:5432/DBNAME"
fly secrets set SUPERSET_SECRET_KEY="change-this-to-a-long-random-secret"
fly secrets set SUPERSET_ADMIN_USERNAME="admin"
fly secrets set SUPERSET_ADMIN_PASSWORD="change-this-password"
fly secrets set SUPERSET_ADMIN_EMAIL="you@example.com"
```

Optional:

```powershell
fly secrets set SUPERSET_ADMIN_FIRSTNAME="Codex"
fly secrets set SUPERSET_ADMIN_LASTNAME="Admin"
```

## Deploy

From this folder:

```powershell
fly launch --no-deploy
```

Then replace the generated config with this `fly.toml` if needed, and run:

```powershell
fly deploy
```

## After Deploy

Your `superset-codex` client should point to the Fly URL:

```text
https://your-app-name.fly.dev
```

Update:

- [superset-codex/.env](C:\Users\TB\Documents\Playground\superset-codex\.env)

## Recommended Next Step

Once Superset is live on Fly, we should:

1. update `superset-codex` to the Fly URL
2. create the target database connection through the CLI
3. create datasets
4. create chart templates
5. let Codex edit charts from natural-language requests
