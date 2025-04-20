# Use the official Odoo 16 image as the base
FROM odoo:16

# Set environment variables for database connection (adjust as per your setup)
ENV ODOO_DB_HOST=postgres.railway.internal
ENV ODOO_DB_PORT=5432
ENV ODOO_DB_USER=postgres
ENV ODOO_DB_PASSWORD=shuwafF2016

# Pin PostgreSQL to the default version from Debian repositories to avoid PGDG conflicts
USER root
RUN echo "Package: *\nPin: origin deb.debian.org\nPin-Priority: 1001" > /etc/apt/preferences.d/pin-debian

# Update and install system dependencies and Python libraries required by Odoo
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    python3-dev \
    libjpeg62-turbo-dev \
    liblcms2-dev \
    libsasl2-dev \
    libldap2-dev \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Optionally, copy your Odoo custom addons or configurations here
# COPY ./your-custom-addons /mnt/extra-addons

# Expose Odoo port (default is 8069)
EXPOSE 8069

# Default command to run Odoo
CMD ["odoo"]
