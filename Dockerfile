FROM ghcr.io/astral-sh/uv:debian
ARG BACKEND_API_PORT=8080
ENV BACKEND_API_PORT=${BACKEND_API_PORT}
WORKDIR /app
COPY ./backend .
ENV UV_NO_DEV=1
RUN ["uv", "sync", "--locked"]
EXPOSE ${BACKEND_API_PORT}
ENTRYPOINT ["/app/entrypoint.sh"]
