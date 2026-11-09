# KLEX

A Laravel application with Inertia and React.

> [!TIP]
> If you want to see an overview of the tech stack and files, check out the [developer overview](/DEVELOPER_OVERVIEW.md).

## Prerequisites

> [!NOTE]
> If you do not want to install the prerequisites, you can use docker compose to run the application instead.

Before running the application, ensure you have the following installed:

- **PHP 8.5+** — The application requires PHP 8.5 or higher.
- **Composer** — For managing PHP dependencies.
- **Node.js 18+** — Required for building frontend assets with Vite.
- **npm** — Comes with Node.js; used for installing JavaScript dependencies.
- **SQLite** — Used as the default database for local development.

## Getting Started

1. **Install PHP dependencies:**

    ```bash
    composer install
    ```

2. **Set up the environment:**

    ```bash
    cp .env.example .env
    php artisan key:generate
    ```

3. **Install JavaScript dependencies:**

    ```bash
    npm install
    ```

4. **Run database migrations:**
    ```bash
    php artisan migrate
    ```
5. **Seed the Database**
    ```bash
    php artisan db:seed
    ```

6**Start the development server:**

```bash
composer dev
```

This will start the Laravel development server, which runs both the backend and the Vite frontend dev server concurrently. The application will be available at `http://localhost:8000`.

## Docker Compose

You can also run the application using Docker Compose, which includes the Laravel app, PostgreSQL database, and a queue worker as separate containers.

### Prerequisites

- **Docker** — [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose** — Comes with Docker Desktop

### Development Setup

For development, the application runs with fresh migrations and seeding on each startup, along with a Vite dev server for hot module replacement. The application key is automatically generated on first run.

1. **Start the development services:**
    ```bash
    docker compose --profile dev up -d --build
    ```

The application will be available at `http://localhost:8000`. The Vite dev server runs on port 5173 for HMR.

### Production Setup

For production-like environments, the application runs with standard migrations and a queue worker.

1. **Start the production services:**

    ```bash
    docker compose --profile prod up -d --build
    ```

2. **Generate an application key (first time only):**
    ```bash
    docker compose exec app php artisan key:generate
    ```

The application will be available at `http://localhost:8000`.

### Docker Services

| Service     | Profile | Description                                           |
| ----------- | ------- | ----------------------------------------------------- |
| `nginx`     | Both    | Nginx web server serving the application on port 8000 |
| `app`       | `prod`  | PHP-FPM container running the Laravel application     |
| `app-dev`   | `dev`   | PHP-FPM container with fresh migrations and seeding   |
| `queue`     | `prod`  | Queue worker processing background jobs               |
| `queue-dev` | `dev`   | Queue worker processing background jobs               |
| `npm`       | `dev`   | Vite dev server with hot module replacement           |
| `db`        | Both    | PostgreSQL 18 database                                |

### Useful Commands

```bash
# View all logs
docker compose logs -f

# View logs for a specific service
docker compose logs -f app
docker compose logs -f queue

# Stop all services
docker compose down

# Stop and remove volumes (reset database)
docker compose down -v

# Restart a specific service
docker compose --profile prod restart queue
docker compose --profile dev restart queue-dev
```
