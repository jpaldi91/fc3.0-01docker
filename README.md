# 1 - Docker

# Introduction

## What is a container?

A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

(**source**: [https://www.docker.com/resources/what-container](https://www.docker.com/resources/what-container/)/)

## Dockerfile

A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image.

Since a new image is always created using a previously existing one, a `Dockerfile` **must begin with a `FROM` instruction**. The `FROM` instruction specifies the Parent Image from which you are building.

The **`RUN`** instruction is another commonly used one. With it, we have the option to customize an image running commands to install packages or print messages, for example.

It is also possible to expose specific image ports in order to provide access to those ports from outside the image using the **`EXPOSE`** instruction.

More information on `Dockerfiles` can be found at [here](https://docs.docker.com/engine/reference/builder/).


# Installing Docker on a Windows PC

There is a really good guide in Portuguese to docker installation using WSL-2 [here](https://github.com/codeedu/wsl2-docker-quickstart#docker-engine-docker-nativo-diretamente-instalado-no-wsl2). I followed the steps described starting at **Docker Engine (Native Docker) directly installed in WSL2.**
