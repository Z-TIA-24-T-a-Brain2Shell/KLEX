FROM php:8.5-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    && docker-php-ext-install pdo_pgsql xml

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node.js and build frontend
RUN curl -fsSL https://deb.nodesource.com/setup_26.x | bash - \
    && apt-get install -y nodejs \
    && npm install \
    && npm run build

# Copy and make entrypoint scripts executable
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY docker/entrypoint-dev.sh /usr/local/bin/entrypoint-dev.sh
COPY docker/entrypoint-queue.sh /usr/local/bin/entrypoint-queue.sh
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/entrypoint-dev.sh /usr/local/bin/entrypoint-queue.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Run migrations on startup, then start PHP-FPM
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
