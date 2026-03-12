FROM apachesuperset.docker.scarf.sh/apache/superset:6.0.0

USER root
RUN uv pip install --python /app/.venv/bin/python psycopg2-binary==2.9.10
USER superset

COPY superset_config.py /app/pythonpath/superset_config.py
COPY --chmod=755 bin/start.sh /app/bin/start.sh
COPY --chmod=755 bin/release.sh /app/bin/release.sh

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

CMD ["/app/bin/start.sh"]
