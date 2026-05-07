# simpleNodeJS

A minimal Node.js example application with a Dockerfile demonstrating how to build and run the app in a container. This README explains the project structure, each file's purpose, how to run locally, and step-by-step Docker examples (build, run, and compose).

---

## Table of Contents

- Project Overview
- Project Structure
- Files Explained
- Prerequisites
- Run Locally
- Docker: Build & Run (Examples)
- Docker Compose Example
- Development Tips
- Troubleshooting
- Contributing & License

---

## Project Overview

`simpleNodeJS` is a tiny Node.js application intended to demonstrate containerizing a Node app using Docker. It's useful as a learning sample or as a starting point for small services.

## Project Structure

```
simpleNodeJS/
├─ Dockerfile
├─ index.js
├─ package.json
└─ README.md
```

## Files Explained

- Dockerfile: Instructions to build a Docker image for this Node.js app. Typically installs dependencies and copies app source into the image.
- index.js: The application entry point. This file should create an HTTP server (or equivalent) and listen on a configurable `PORT`.
- package.json: Declares project metadata and dependencies and can include npm scripts such as `start`.
- README.md: This file — usage and documentation.

If you'd like more structure (src/, test/, etc.), consider creating corresponding folders and updating the Dockerfile to copy them into the image.

## Prerequisites

- Node.js (for local run) — optional if you only use Docker.
- Docker (Engine) installed for building and running containers.

## Run Locally (without Docker)

1. Install dependencies:

```bash
npm install
```

2. Start the app directly:

```bash
node index.js
```

If `package.json` defines a `start` script, you can use `npm start` instead.

## Docker: Build & Run (Examples)

Below are simple, copy-paste examples showing common Docker workflows. Adjust ports, image names, and env vars as needed for your app.

1) Build a Docker image

```bash
# From project root (where Dockerfile is located)
docker build -t simple-nodejs:latest .
```

2) Run the image (map port to host)

```bash
# Example assumes app listens on PORT 3000 inside the container
docker run --rm -it -p 3000:3000 --name simple-nodejs-run simple-nodejs:latest
```

3) Pass environment variables (eg. PORT or NODE_ENV)

```bash
docker run --rm -it -p 4000:4000 -e PORT=4000 -e NODE_ENV=production simple-nodejs:latest
```

4) Run with an interactive development volume (live code edit)

```bash
docker run --rm -it -p 3000:3000 -v "$(pwd)":/usr/src/app -w /usr/src/app node:18 sh -c "npm install && node index.js"
```

Notes:
- Replace `node:18` and `PORT` with versions/ports used in your project.
- On Windows PowerShell, replace `$(pwd)` with `${PWD}` if needed.

### Dockerfile explanation (common pattern)

A simple Dockerfile for Node.js often follows these steps:

1. Use an official Node base image (eg. `node:18`)
2. Set working directory, copy `package.json` and `package-lock.json` then `npm install`
3. Copy source files and `CMD ["node", "index.js"]` to start the app

Example (multi-stage or single-stage) is already present in your `Dockerfile` — inspect it to confirm matching Node version and exposed port.

## Docker Compose Example

Create a `docker-compose.yml` if you want to orchestrate services or simplify run commands. Example:

```yaml
version: '3.8'
services:
	app:
		build: .
		image: simple-nodejs:local
		ports:
			- "3000:3000"
		environment:
			- PORT=3000
		volumes:
			- ./:/usr/src/app # optional for development

```

Then run:

```bash
docker compose up --build
```

## Development Tips

- Keep `PORT` configurable via `process.env.PORT` in `index.js` so Docker and local runs behave consistently.
- Use `.dockerignore` to reduce image size (ignore node_modules, logs, .git, etc.).
- For production images, use multi-stage builds to keep final image lightweight.

## Troubleshooting

- If container fails to start, check logs with:

```bash
docker logs <container-name-or-id>
```

- If port appears unreachable, verify the app listens on the expected `PORT` and that you published the correct host port mapping with `-p`.

## Contributing

Feel free to open issues or PRs to improve the sample, add tests, or demonstrate multi-service setups.

## License

This project is provided as-is for learning and demonstration. Add a license file if you plan to reuse or publish it.
