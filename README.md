# KLEX

A Laravel application with Inertia and React.

## Prerequisites

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

This will start the Laravel Pao development server, which runs both the backend and the Vite frontend dev server concurrently. The application will be available at `http://localhost:8000`.

## Docker Compose

You can also run the application using Docker Compose, which includes the Laravel app, PostgreSQL database, and a queue worker as separate containers.

### Prerequisites

- **Docker** — [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose** — Comes with Docker Desktop

### Running with Docker

1. **Start all services:**
   ```bash
   docker compose up -d --build
   ```

2. **Generate an application key and run migrations:**
   ```bash
   docker compose exec app php artisan key:generate
   docker compose exec app php artisan migrate
   ```

3. **Seed the database (optional):**
   ```bash
   docker compose exec app php artisan db:seed
   ```

The application will be available at `http://localhost:8000`.

### Docker Services

| Service | Description |
|---------|-------------|
| `nginx` | Nginx web server serving the application on port 8000 |
| `app` | PHP-FPM container running the Laravel application |
| `queue` | Queue worker processing background jobs |
| `db` | PostgreSQL 18 database |

### Useful Commands

```bash
# View logs
docker compose logs -f

# View queue worker logs
docker compose logs -f queue

# Stop all services
docker compose down

# Stop and remove volumes (reset database)
docker compose down -v

# Restart a specific service
docker compose restart queue
```
