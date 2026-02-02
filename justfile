set dotenv-load := true

export backend-api-port := env('BACKEND_API_PORT')

api-sync:
    uv sync --directory backend

run-api-dev:
    echo "running api on port {{ backend-api-port }}"
    uv run --directory backend fastapi dev main.py

run-frontend-dev:
    bun --cwd frontend --bun next dev

build-frontend:
    bun --cwd frontend --bun next build

start-frontend:
    bun --cwd frontend --bun next start
