#!/bin/sh
exec uv run fastapi run main.py --host 0.0.0.0 --port "${BACKEND_API_PORT:-8080}"
