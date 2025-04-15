# Use an official Odoo image as a base
FROM odoo:16

ENV HOME /opt/odoo
WORKDIR /opt/odoo

COPY ./odoo.conf /etc/odoo.conf
COPY ./requirements.txt /opt/odoo/requirements.txt
COPY ./addons /opt/odoo/addons

RUN pip install -r /opt/odoo/requirements.txt

EXPOSE 8069

CMD ["odoo", "-c", "/etc/odoo.conf"]
