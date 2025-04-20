# Use the official Odoo 16 image as the base
FROM odoo:16

# Switch to root for installing packages
USER root

# 1. Install tools to add the PostgreSQL APT repo
RUN apt-get update && \
    apt-get install -y wget gnupg lsb-release

# 2. Add the PostgreSQL Global Development Group (PGDG) repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" \
      > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
      | apt-key add -

# 3. Update and install C libraries & headers, pulling libpq-dev/libpq5 from PGDG
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      libssl-dev \
      libffi-dev \
      libpq-dev \
      python3-dev \
      libjpeg62-turbo-dev \
      liblcms2-dev \
      libsasl2-dev \
      libldap2-dev \
      zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to the odoo user
USER odoo

# Copy Odoo config, requirements, and addons
COPY ./odoo.conf /etc/odoo/odoo.conf
COPY ./requirements.txt /opt/odoo/requirements.txt
COPY ./addons /opt/odoo/addons

WORKDIR /opt/odoo

# Install Python dependencies (including any C extensions needing libpq-dev)
RUN pip install --no-cache-dir -r requirements.txt

# Expose Odoo’s HTTP port
EXPOSE 8069

# Entrypoint is the default Odoo command
CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
