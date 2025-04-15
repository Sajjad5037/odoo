# Use an official Odoo image as a base
FROM odoo:16

# Install system dependencies required for Odoo
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    python3-dev \
    libjpeg8-dev \
    liblcms2-dev \
    libsasl2-dev \
    libldap2-dev \
    zlib1g-dev

ENV HOME /opt/odoo
WORKDIR /opt/odoo

COPY ./odoo.conf /etc/odoo.conf
COPY ./requirements.txt /opt/odoo/requirements.txt
COPY ./addons /opt/odoo/addons

# Install Python dependencies
RUN pip install -r /opt/odoo/requirements.txt

EXPOSE 8069

CMD ["odoo", "-c", "/etc/odoo.conf"]
