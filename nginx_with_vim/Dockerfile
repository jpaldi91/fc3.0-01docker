FROM nginx:latest

# creates a directory "/app" and runs the next commands from there
WORKDIR /app

# the -y automatically confirms the download the install command will make
RUN apt-get update && \
   apt-get install vim -y

# copies the html directory to the destination path
COPY html/ /usr/share/nginx/html
