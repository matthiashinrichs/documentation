FROM nginx

COPY site /usr/share/nginx/html
COPY site/index.html /usr/share/nginx/html/index.html
