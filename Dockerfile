FROM alpine:latest

RUN apk update && apk add nginx git

RUN rm /etc/nginx/nginx.conf

RUN git clone https://github.com/veekrum/task /tmp/task

RUN mv /tmp/task /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 9000

CMD ["nginx", "-g", "daemon off;"]