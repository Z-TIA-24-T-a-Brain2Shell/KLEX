# KLEX

A Laravel application with Inertia and React.

## Prerequisites

Before running the application, ensure you have the following installed:

- **PHP 8.3+** — The application requires PHP 8.3 or higher.
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

5. **Start the development server:**
   ```bash
   composer dev
   ```

This will start the Laravel Pao development server, which runs both the backend and the Vite frontend dev server concurrently. The application will be available at `http://localhost:8000`.
