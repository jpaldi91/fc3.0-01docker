FROM nginx:latest

# creates a directory "/app" and runs the next commands from there
WORKDIR /app

# the -y automatically confirms the download the install command will make
RUN apt-get update && \
   apt-get install vim -y

# copies the html directory to the destination path.
# the content being copied needs to be in the same path or in a child directory of where the Dockerfile is located
COPY html /usr/share/nginx/html

# same entrypoint and cmd at the Dockerfile of the nginx image
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
