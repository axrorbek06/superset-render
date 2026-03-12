import os


def _env(name: str, default: str = "") -> str:
    return os.getenv(name, default)


SQLALCHEMY_DATABASE_URI = _env("DATABASE_URL")
SECRET_KEY = _env("SUPERSET_SECRET_KEY")

if not SQLALCHEMY_DATABASE_URI:
    raise RuntimeError("DATABASE_URL is required")

if not SECRET_KEY:
    raise RuntimeError("SUPERSET_SECRET_KEY is required")

SUPERSET_WEBSERVER_PORT = int(_env("SUPERSET_PORT", "8088"))
WTF_CSRF_ENABLED = True
SQLLAB_CTAS_NO_LIMIT = True
ROW_LIMIT = 5000

# Keep the first deployment small and stable.
FEATURE_FLAGS = {
    "ALERT_REPORTS": False,
}
