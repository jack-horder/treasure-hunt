set dotenv-load := true

export backend-api-port := env('BACKEND_API_PORT')

run-api:
    echo "running api on port {{ backend-api-port }}"
    uv run fastapi dev api/main.py
