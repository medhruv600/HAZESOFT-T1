FROM alpine:latest

RUN apk add nginx

RUN apk add git

RUN git clone https://github.com/veekrum/task.git /tmp/task

COPY nginx.conf /etc/nginx/nginx.conf

RUN cp -r /tmp/task/site/. /usr/share/nginx/html

EXPOSE 9000

CMD ["nginx", "-g", "daemon off;"]