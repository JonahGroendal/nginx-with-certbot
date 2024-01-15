FROM docker.io/nginx

RUN apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    certbot \
    python3-certbot-nginx

# Copy the startup script into the Docker container
COPY startup.sh /startup.sh
COPY reconfigure.sh /reconfigure.sh
RUN chmod +x /startup.sh
RUN chmod +x /reconfigure.sh

CMD /startup.sh
