FROM ghcr.io/astral-sh/uv:debian

ARG BACKEND_API_PORT=8080

WORKDIR /app
# The installer requires curl (and certificates) to download the release archive
# Copy the project into the image
COPY backend/ .

# Disable development dependencies
ENV UV_NO_DEV=1

# Sync the project into a new environment, asserting the lockfile is up to date
RUN uv sync --locked

EXPOSE ${BACKEND_API_PORT}

CMD [ "uv run fastapi run main.py" ]
