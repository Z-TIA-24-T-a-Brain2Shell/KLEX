# Developer Overview

This document provides a quick reference for the key areas of the application — where to find things and what they do.

---

## Tech Stack

| Layer          | Technology                                   | Documentation                                                                           |
| -------------- | -------------------------------------------- | --------------------------------------------------------------------------------------- |
| Backend        | Laravel 13 (PHP 8.5)                         | [Laravel Docs](https://laravel.com/docs/13.x)                                           |
| Frontend       | React + TypeScript (Inertia.js v3)           | [Inertia.js Docs](https://inertiajs.com/)                                               |
| Authentication | Laravel Fortify (with 2FA and Passkeys)      | [Fortify Docs](https://laravel.com/docs/13.x/fortify)                                   |
| Styling        | Tailwind CSS + shadcn/ui components          | [Tailwind Docs](https://tailwindcss.com/docs) · [shadcn/ui](https://ui.shadcn.com/docs) |
| Build Tool     | Vite                                         | [Vite Docs](https://vite.dev/guide/)                                                    |
| Database       | PostgreSQL 18                                | [PostgreSQL Docs](https://www.postgresql.org/docs/18/)                                  |
| Route Binding  | Laravel Wayfinder (TypeScript route helpers) | [Wayfinder Docs](https://github.com/laravel/wayfinder)                                  |
| Testing        | Pest                                         | [Pest Docs](https://pestphp.com/docs/)                                                  |

---

## Backend

### Routes

| File                  | Purpose                                                                      |
| --------------------- | ---------------------------------------------------------------------------- |
| `routes/web.php`      | Public routes: welcome page and authenticated dashboard                      |
| `routes/settings.php` | Settings routes: profile, security (password, 2FA, passkeys), and appearance |
| `routes/console.php`  | Scheduling and Tinker aliases                                                |

Auth routes (login, register, password reset, 2FA challenge) are provided by **Laravel Fortify** and configured in `FortifyServiceProvider`.

### Controllers

| File                                                   | Purpose                                                               |
| ------------------------------------------------------ | --------------------------------------------------------------------- |
| `app/Http/Controllers/Controller.php`                  | Base controller class                                                 |
| `app/Http/Controllers/Settings/ProfileController.php`  | Edit, update, and delete user profiles                                |
| `app/Http/Controllers/Settings/SecurityController.php` | Security settings page (password, 2FA, passkeys) and password updates |

### Middleware

| File                                            | Purpose                                                                    |
| ----------------------------------------------- | -------------------------------------------------------------------------- |
| `app/Http/Middleware/HandleInertiaRequests.php` | Shared Inertia props: app name, authenticated user, and sidebar state      |
| `app/Http/Middleware/HandleAppearance.php`      | Reads the `appearance` cookie and shares it with views for dark/light mode |

### Models

| File                  | Purpose                                                                         |
| --------------------- | ------------------------------------------------------------------------------- |
| `app/Models/User.php` | User model with email verification, 2FA, and passkey support via Fortify traits |

### Form Requests

| File                                                            | Purpose                                                |
| --------------------------------------------------------------- | ------------------------------------------------------ |
| `app/Http/Requests/Settings/ProfileUpdateRequest.php`           | Validates profile update (name, email)                 |
| `app/Http/Requests/Settings/ProfileDeleteRequest.php`           | Validates account deletion (requires current password) |
| `app/Http/Requests/Settings/PasswordUpdateRequest.php`          | Validates password changes                             |
| `app/Http/Requests/Settings/TwoFactorAuthenticationRequest.php` | Validates 2FA setup and management                     |

### Fortify Actions

| File                                        | Purpose                                                       |
| ------------------------------------------- | ------------------------------------------------------------- |
| `app/Actions/Fortify/CreateNewUser.php`     | Custom user registration with profile and password validation |
| `app/Actions/Fortify/ResetUserPassword.php` | Custom password reset with validation                         |

### Concerns (Reusable Traits)

| File                                       | Purpose                                |
| ------------------------------------------ | -------------------------------------- |
| `app/Concerns/PasswordValidationRules.php` | Shared password validation rules       |
| `app/Concerns/ProfileValidationRules.php`  | Shared name and email validation rules |

### Service Providers

| File                                       | Purpose                                                                                                                 |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| `app/Providers/AppServiceProvider.php`     | Sets immutable dates, prohibits destructive DB commands in production, and enforces strong password rules in production |
| `app/Providers/FortifyServiceProvider.php` | Configures Fortify: custom actions, Inertia auth views, and rate limiting for login/2FA/passkeys                        |

---

## Frontend

### Entry Point

| File                   | Purpose                                                                                                                                                                  |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `resources/js/app.tsx` | Inertia app bootstrap: layout delegation (welcome → none, auth → AuthLayout, settings → AppLayout + SettingsLayout), tooltip provider, toaster, and theme initialization |

### Layouts

| File                                       | Purpose                                         |
| ------------------------------------------ | ----------------------------------------------- |
| `resources/js/layouts/app-layout.tsx`      | Main application layout with sidebar and header |
| `resources/js/layouts/auth-layout.tsx`     | Authentication pages layout                     |
| `resources/js/layouts/settings/layout.tsx` | Settings pages sub-layout with navigation       |

### Pages (Inertia Components)

| File                                               | Purpose                                            |
| -------------------------------------------------- | -------------------------------------------------- |
| `resources/js/pages/welcome.tsx`                   | Public landing page                                |
| `resources/js/pages/dashboard.tsx`                 | Authenticated dashboard                            |
| `resources/js/pages/auth/login.tsx`                | Login form with 2FA and passkey support            |
| `resources/js/pages/auth/register.tsx`             | User registration                                  |
| `resources/js/pages/auth/forgot-password.tsx`      | Password reset request                             |
| `resources/js/pages/auth/reset-password.tsx`       | Password reset form                                |
| `resources/js/pages/auth/confirm-password.tsx`     | Password confirmation gate                         |
| `resources/js/pages/auth/two-factor-challenge.tsx` | 2FA verification challenge                         |
| `resources/js/pages/settings/profile.tsx`          | Profile edit and account deletion                  |
| `resources/js/pages/settings/security.tsx`         | Password change, 2FA setup, and passkey management |
| `resources/js/pages/settings/appearance.tsx`       | Dark/light mode toggle                             |

### Reusable Components

| Directory                                     | Purpose                                                      |
| --------------------------------------------- | ------------------------------------------------------------ |
| `resources/js/components/ui/`                 | shadcn/ui primitives (button, dialog, input, dropdown, etc.) |
| `resources/js/components/app-*.tsx`           | App shell, header, sidebar, and logo components              |
| `resources/js/components/manage-*.tsx`        | 2FA and passkey management UI                                |
| `resources/js/components/delete-user.tsx`     | Account deletion confirmation dialog                         |
| `resources/js/components/password-input.tsx`  | Password input with show/hide toggle                         |
| `resources/js/components/appearance-tabs.tsx` | Theme selection tabs                                         |

### Hooks

| File                                          | Purpose                               |
| --------------------------------------------- | ------------------------------------- |
| `resources/js/hooks/use-appearance.tsx`       | Dark/light mode state and persistence |
| `resources/js/hooks/use-clipboard.ts`         | Copy-to-clipboard utility             |
| `resources/js/hooks/use-current-url.ts`       | Current URL tracking                  |
| `resources/js/hooks/use-flash-toast.ts`       | Flash message toast notifications     |
| `resources/js/hooks/use-initials.tsx`         | Generate user initials from name      |
| `resources/js/hooks/use-mobile-navigation.ts` | Mobile menu state management          |
| `resources/js/hooks/use-mobile.tsx`           | Mobile breakpoint detection           |
| `resources/js/hooks/use-two-factor-auth.ts`   | 2FA setup and management logic        |

### Wayfinder (TypeScript Route Helpers)

| Directory               | Purpose                                                    |
| ----------------------- | ---------------------------------------------------------- |
| `resources/js/actions/` | Auto-generated TypeScript functions for controller actions |
| `resources/js/routes/`  | Auto-generated TypeScript functions for named routes       |

Import from `@/routes/[route-name]` or `@/actions/[controller-path]` instead of hardcoding URLs.

### Types

| File                               | Purpose                                 |
| ---------------------------------- | --------------------------------------- |
| `resources/js/types/index.ts`      | Re-exported TypeScript types            |
| `resources/js/types/auth.ts`       | Authentication-related type definitions |
| `resources/js/types/navigation.ts` | Navigation item types                   |
| `resources/js/types/ui.ts`         | UI component prop types                 |

---

## Database

| Directory              | Purpose                                               |
| ---------------------- | ----------------------------------------------------- |
| `database/migrations/` | Schema migrations (users, cache, jobs, 2FA, passkeys) |
| `database/factories/`  | Model factories for testing and seeding               |
| `database/seeders/`    | Database seeders                                      |

---

## Configuration

| File                 | Purpose                                                                           |
| -------------------- | --------------------------------------------------------------------------------- |
| `config/fortify.php` | Fortify features: registration, password reset, 2FA, passkeys, email verification |
| `config/inertia.php` | Inertia server-side configuration                                                 |
| `config/app.php`     | Application name, timezone, and service providers                                 |

---

## Testing

| Directory        | Purpose                                            |
| ---------------- | -------------------------------------------------- |
| `tests/Feature/` | Feature tests for auth, settings, and API behavior |
| `tests/Unit/`    | Unit tests for individual components               |
| `tests/Pest.php` | Pest test configuration and helpers                |

---

## Useful Commands

```bash
# List all routes
php artisan route:list

# Run tests
php artisan test

# Format code
vendor/bin/pint --dirty

# Build frontend assets
npm run build

# Run dev server
composer dev
```

---

## Documentation

### Laravel Ecosystem

- [Laravel 13 Documentation](https://laravel.com/docs/13.x) — Main framework documentation
- [Laravel Fortify](https://laravel.com/docs/13.x/fortify) — Authentication scaffolding (2FA, passkeys, email verification)
- [Laravel Wayfinder](https://github.com/laravel/wayfinder) — TypeScript route helpers
- [Laravel Pint](https://laravel.com/docs/13.x/pint) — Code style fixer

### Frontend

- [Inertia.js v3](https://inertiajs.com/) — SPA without an API
- [Inertia.js React Adapter](https://inertiajs.com/docs/v3/installation/client-side-setup#using-axios) — React-specific Inertia features
- [Tailwind CSS](https://tailwindcss.com/docs) — Utility-first CSS framework
- [shadcn/ui](https://ui.shadcn.com/docs) — Reusable UI components
- [Vite](https://vite.dev/guide/) — Frontend build tool

### Testing

- [Pest](https://pestphp.com/docs/) — Elegant PHP testing framework
- [Laravel Testing](https://laravel.com/docs/13.x/testing) — Laravel-specific testing guides

### Database

- [PostgreSQL 18](https://www.postgresql.org/docs/18/) — Database documentation
- [Laravel Eloquent](https://laravel.com/docs/13.x/eloquent) — ORM documentation
- [Laravel Migrations](https://laravel.com/docs/13.x/migrations) — Schema management
