# HAZESOFT-T1

First and foremost download the docker installer from docker website ie www.docker.com according to your OS. In my case, I downloaded docker desktop which is a installer for windows and then installed it with WSL2 option as we can run docker with WSL and even with Hyper-V in windows.

Then, I created a public repo with HAZESOFT-T1 name along with README.md file for writing down the steps involved to achieve the given task in github.

Again, created Dockerfile with no extension and nginx.config file in order to write the command to automate the given task.

Then I cloned that repo in my local machine and after a long R&D I am able to write down the code and command which is mentioned below.

#Dockerfile

FROM alpine:latest
-This line sets the latest version of Alpine Linux as the base image.

RUN apk add nginx
-This line uses the package manager apk to install the Nginx web server in the Alpine Linux environment.

RUN apk add git
-Does same, instead nginx, it install Git which is required later in the Dockerfile to clone a Git repository.

RUN git clone https://github.com/veekrum/task.git /tmp/task
-This line clones a Git repository (https://github.com/veekrum/task.git) into the /tmp/task directory inside the Docker image which will be used later.

COPY nginx.conf /etc/nginx/nginx.conf
-This line copies a custom Nginx configuration file (nginx.conf) from the local build context to the /etc/nginx/nginx.conf path inside the Docker image. This allows you to customize the Nginx configuration.

RUN cp -r /tmp/task/site/. /usr/share/nginx/html
-This line copies the contents of the /tmp/task/site/ directory into the Nginx web server's default root directory, which is /usr/share/nginx/html.

EXPOSE 9000
-This line informs Docker that the container will listen on port 9000 at runtime.

CMD ["nginx", "-g", "daemon off;"]
-This line specifies the default command to run when the container starts. It starts the Nginx server and runs it in the foreground with the specified configuration (-g daemon off;). This is a common approach to keep the container running, as Nginx would otherwise start in the background and the container would exit.

#nginx.conf

worker_processes 1;

events {
    worker_connections 1024;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 80;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            index index.html;
            try_files $uri $uri/ /index.html;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
        }
    }
}
In nginx.conf, I am able to understand much of line 56 ie listen on the port 80 which is then mapped to some different or same port in order to access the file in our local machine at the specified port and of line 59 ie location to setup the path from where we can access our file which is utilized later.
