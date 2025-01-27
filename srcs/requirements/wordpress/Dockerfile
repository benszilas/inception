FROM wordpress:php8.1-fpm

# Install dependencies and WP-CLI
RUN apt-get update && apt-get install -y \
    less \
    mariadb-client \
    curl \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the setup script
COPY ./conf/wp-cli-setup.sh /tmp/wp-cli-setup.sh
RUN chmod +x /tmp/wp-cli-setup.sh
	
# Add a non-root user
RUN useradd -m wpuser && chown -R puser:www-data /var/www/html && chown puser:www-data /tmp/wp-cli-setup.sh

# Switch to non-root user
USER wpuser

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/tmp/wp-cli-setup.sh"]