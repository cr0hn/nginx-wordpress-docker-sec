FROM nginx:latest

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y libterm-readline-perl-perl && apt-get install -y nginx-common && apt-get upgrade -y nginx && \
    apt-get install -y libnginx-mod-http-headers-more-filter && apt-get clean

COPY default.conf /etc/nginx/conf.d/default.conf
COPY wordpress.conf /etc/nginx/global/wordpress.conf
COPY restrictions.conf /etc/nginx/global/restrictions.conf
COPY proxy.conf /etc/nginx/global/proxy.conf
COPY docker-entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY custom-errors.conf /etc/nginx/custom-errors.conf
COPY error_pages/* /usr/share/nginx/html/

RUN chmod -R 755 /usr/share/nginx/html && \
    chown -R www-data:www-data /usr/share/nginx/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]