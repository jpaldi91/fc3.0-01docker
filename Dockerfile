FROM nginx:latest

RUN apt-get update
# the -y automatically confirms the download the install command will make
RUN apt-get install vim -y