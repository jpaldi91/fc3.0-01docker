# 1 - Docker

## Introduction

### What is a container?

A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

(**source**: [https://www.docker.com/resources/what-container](https://www.docker.com/resources/what-container/)/)

### Dockerfile

A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image.

Since a new image is always created using a previously existing one, a `Dockerfile` **must begin with a `FROM` instruction**. The `FROM` instruction specifies the Parent Image from which you are building.

The **`RUN`** instruction is another commonly used one. With it, we have the option to customize an image running commands to install packages or print messages, for example.

It is also possible to expose specific image ports in order to provide access to those ports from outside the image using the **`EXPOSE`** instruction.

More information on `Dockerfiles` can be found at [here](https://docs.docker.com/engine/reference/builder/).

## Installing Docker on a Windows PC

There is a really good guide in Portuguese to docker installation using WSL-2 [here](https://github.com/codeedu/wsl2-docker-quickstart#docker-engine-docker-nativo-diretamente-instalado-no-wsl2). I followed the steps described starting at **Docker Engine (Native Docker) directly installed in WSL2.**

💡 **Note:** Instead of installing the WSL distro through Microsoft Store, in order to save space on my SSD, I’ve ran on the Powershell the steps bellow I found [here](https://superuser.com/questions/1572834/is-there-any-way-to-install-wsl-on-non-c-drive):

```bash
# Substitute the drive on which you
# want WSL to be installed if not D:
Set-Location D:

# Create a directory for WSL and change to it:
New-Item WSL -Type Directory
Set-Location .\WSL

# Using the URL you found above, download the appx package:
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2204 -OutFile Ubuntu.appx -UseBasicParsing

# Make a backup and unpack:
Copy-Item .\Ubuntu.appx .\Ubuntu.zip
Expand-Archive .\Ubuntu.zip

# Find the installer:
Get-ChildItem *.exe -Recurse
```

## How to backup and restore your whole WSL2 partition

### Backup

For the steps followed in this document, the `ext4.vhdx` (which is a whole wsl2 partition) in `D:\WSL\Ubuntu`

### Restore

1. Install the same Linux distro in your WSL again
2. Create a user with the same credentials as before
3. Run `wsl --shutdown` in Powershell
4. Override the `ext4.vhdx` file that was just now created created for the file you saved before

## Basic commands

<details>
<summary>When running <code style="white-space:nowrap;">docker run hello-world</code>, Docker tried to run an image called <code style="white-space:nowrap;">hello-world</code> that wasn’t found locally, then it pulled that image from the library. After the new image was downloaded, it printed some text as it was defined in the image.</summary>
  
    Unable to find image 'hello-world:latest' locally
    latest: Pulling from library/hello-world
    2db29710123e: Pull complete
    Digest: sha256:ffb13da98453e0f04d33a6eee5bb8e46ee50d08ebe17735fc0779d0349e889e9
    Status: Downloaded newer image for hello-world:latest
    
    Hello from Docker!
    This message shows that your installation appears to be working correctly.
    
    To generate this message, Docker took the following steps:
     1. The Docker client contacted the Docker daemon.
     2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
     3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
     4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.
    
    To try something more ambitious, you can run an Ubuntu container with:
     $ docker run -it ubuntu bash
    
    Share images, automate workflows, and more with a free Docker ID:
     https://hub.docker.com/
    
    For more examples and ideas, visit:
     https://docs.docker.com/get-started/
  
</details>

<details>
<summary><code style="white-space:nowrap;">docker ps</code> shows the running containers’ information. However, since the <code style="white-space:nowrap;">hello-world</code> has already exited, it won’t appear in this command’s output</summary>
  
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
  
</details>

<details>
<summary>Run <code style="white-space:nowrap;">docker ps -a</code> to view <b>all</b> containers (including those which already exited)</summary>
  
    CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                      PORTS     NAMES
	5b4376984cdc   hello-world   "/hello"   32 minutes ago   Exited (0) 32 minutes ago             funny_jones
  
</details>

<details>
<summary><code style="white-space:nowrap;">docker run -it ubuntu bash</code> runs with <code style="white-space:nowrap;">-it</code>, or <code style="white-space:nowrap;">-i</code> (interactive, keeps STDIN open even if the terminal is not attached to the container) and <code style="white-space:nowrap;">-t</code> (allocates a pseudo-TTY, which stands for Teletype, enabling basic input-output) parameters the <code style="white-space:nowrap;">ubuntu</code> image and calls the bash command. We can also add <code style="white-space:nowrap;">--rm</code> just before the image name in order to remove the container when it exits.</summary>
  
    root@289a8371ff9f:/#
  
</details>

## Publishing ports with nginx

`docker run nginx` runs the **nginx** (its pronounced Engine X) image and the container behaves like a web server with the port `80` opened for tcp traffic. However, in order to access this port, we need to also **publish** it with the `-p` argument some way like this:

`docker run -p 8080:80 nginx`

This way, docker publishes the port `80` of the container running **nginx** as the port `8080` in the outside machine. So when accessing [localhost:8080](http://localhost:8080) in a browser, here’s what we see:

<p align="center">
    <img src="https://user-images.githubusercontent.com/17324018/228924429-759b3ead-2008-41eb-a4d7-c8a0d50e7ca2.png" align="center">
</p>

And also, it is also possible to see several logs in the terminal running this container. However, if we decide to keep using the terminal and let the container running on the background, all that is needed is to add a `-d` argument to run the container detached: `docker run -d -p 8080 nginx`

## Start, Stop and Remove commands

Every time we use the `docker run`, a new container is created and that may be checked using the `docker ps -a` command.

```bash
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                        PORTS     NAMES
a9b72512a8e4   nginx         "/docker-entrypoint.…"   26 minutes ago   Exited (0) 11 minutes ago               wonderful_driscoll
d9141dd55238   nginx         "/docker-entrypoint.…"   39 minutes ago   Exited (0) 27 minutes ago               wonderful_carson
289a8371ff9f   ubuntu        "bash"                   55 minutes ago   Exited (0) 54 minutes ago               pedantic_williams
aa0f2e0bb04d   ubuntu        "bash"                   58 minutes ago   Exited (137) 56 minutes ago             busy_robinson
41439aa71bf5   ubuntu        "bash"                   59 minutes ago   Exited (0) 58 minutes ago               frosty_dijkstra
52a37b2b3bfa   ubuntu        "bash"                   59 minutes ago   Exited (0) 59 minutes ago               brave_mccarthy
5b4376984cdc   hello-world   "/hello"                 17 hours ago     Exited (0) 17 hours ago                 funny_jones
```

If this is unintended and we want to run a previously created container, we can just use `start` instead of `run`, and pass the `CONTAINER ID` or its’ name, instead of the image name, as seen below:

```bash
jp@G7:~$ docker start a9b72512a8e4
a9b72512a8e4
jp@G7:~$ docker start pedantic_williams
pedantic_williams
jp@G7:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED             STATUS          PORTS                                   NAMES
a9b72512a8e4   nginx     "/docker-entrypoint.…"   31 minutes ago      Up 34 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   wonderful_driscoll
289a8371ff9f   ubuntu    "bash"                   About an hour ago   Up 4 seconds                                            pedantic_williams
```

Otherwise, if we want to **stop** or **remove** an existing container in the same way, just typing the desired command `stop` or `rm`:

```bash
jp@G7:~$ docker stop a9b72512a8e4
a9b72512a8e4
jp@G7:~$ docker remove funny_jones
funny_jones
jp@G7:~$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED             STATUS                           PORTS     NAMES
a9b72512a8e4   nginx     "/docker-entrypoint.…"   37 minutes ago      Exited (0) About a minute ago              wonderful_driscoll
d9141dd55238   nginx     "/docker-entrypoint.…"   49 minutes ago      Exited (0) 37 minutes ago                  wonderful_carson
289a8371ff9f   ubuntu    "bash"                   About an hour ago   Up 5 minutes                               pedantic_williams
aa0f2e0bb04d   ubuntu    "bash"                   About an hour ago   Exited (137) About an hour ago             busy_robinson
41439aa71bf5   ubuntu    "bash"                   About an hour ago   Exited (0) About an hour ago               frosty_dijkstra
52a37b2b3bfa   ubuntu    "bash"                   About an hour ago   Exited (0) About an hour ago               brave_mccarthy
```

Additionally, it is possible to avoid the created containers having crazy names like “funny_jones” and “frosty_dijkstra” by **naming** the container to be created on the `docker run` command:

```bash
jp@G7:~$ docker run --name nginx_container -d -p 8080:80 nginx
a7f30cd1797baf1ae83a71e4ba94ce54b4602fa61c19e68ea4241b8921c7a548
jp@G7:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                   NAMES
a7f30cd1797b   nginx     "/docker-entrypoint.…"   5 seconds ago   Up 3 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx_container
```

## Accessing and changing files inside a container

It is possible to **execute** commands inside an **already running** container using the `docker exec` command:

```bash
jp@G7:~$ docker exec nginx_container echo 'hi'
hi
```

Note that in the same way we called the bash command inside a ubuntu container being created previously, we can execute it in an already running container:

```bash
jp@G7:~$ docker exec -it nginx_container bash
root@a7f30cd1797b:/#
```

Let’s now change the index page we saw earlier when accessing the nginx published port. If you try running a text editor inside the container, you’ll notice it doesn’t have it installed. It also doesn’t have an apt-get cache, so we’ll need to run the following:

```bash
apt-get update
apt-get -y install vim
```

Now, vim is not exactly a simple text editor to use, so I’ll just skip that part and show the result of my new index page published in the port 80 by nginx:
<p align="center">
    <img src="https://user-images.githubusercontent.com/17324018/228926073-f67c206d-b11f-4626-88fc-dc4255c7b747.png" align="center">
</p>

An important note is that Docker images are immutable. Which means that if this container is removed all changes will be lost, even if we create another one using the same image.

To prevent work loss in such occasions, it is possible to **bind mount** a folder or a volume when creating a container using the `--mount` arguments like this:

```bash
jp@G7:~/projects/fc3/01docker$ docker run -d --name nginx -p 8080:80 --mount type=bind,source="$(pwd)/html",target=/usr/share/nginx/html nginx
08b55f7fddb745bf6929f5e0137d42b3a1c90c210746de66e0b61f7ca13dfdc6
```

This will mount the `$(pwd)/html` folder in the host machine to the target folder in the container, in a way that both non-Docker processes on the Docker host or a Docker container can modify them at any time.
<p align="center">
    <img src="https://user-images.githubusercontent.com/17324018/228943664-20e9368b-a502-4ba3-914f-1a3fc9e56ee0.png" align="center">
</p>

Another possible solution is to use the `-v` option like this:

`docker run -d -v "$(pwd)"/volume/managed_by_docker:/path/to/folder/inside/container nginx`

This option, as hinted above, will create a `volume` folder with a volume named `managed_by_docker` inside that will be managed by docker itself. Which means non-Docker processes should not modify this part of the filesystem.

## Working with volumes

It is possible to create volumes and mount them in one or several containers.

To **create a volume**, simply type `docker volume create volume_name`

To **list the created volumes**, type `docker volume ls`

To **inspect a specific volume**, type `docker volume inspect volume_name`

Similarly to bind mounting a folder to a container, we can mount a volume using `--mount type=volume source=volume_name` instead of `--mount type=bind,source=/path/to/folder/`

`docker run --name nginx -d --mount type=volume,source=my_volume,target=/app nginx`

This is the same thing as using `docker run --name nginx -d -v volume_name:/app nginx`

To free some disk space and **remove volumes not used**, type: `docker volume prune`

## Working with images

Every time we run a container with an image we don't locally have, docker pulls that image from the container registry and downloads the missing dependencies. When the container registry is not specified in the image name, Docker’s pulls that image from it’s own container registry, which is called DockerHub.

To specify a specific version of an image, we simply need to add `:version-name` after the image name. Until now, we didn’t specify any image version, so by default what is happening is the same thing as if we were typing `:latest` instead of a specific version.

It is also possible to pull an image from the registry without necessarily running a container. For that, we just type `docker pull image:version`

To list all images locally present, just type `docker images`

To remove a local specific image, just type `docker rmi image:version`

## Creating an image with Dockerfile

As mentioned in the beginning of the course, new images are specified creating a `Dockerfile`, which **must begin with a `FROM` instruction**.

In this course, we created an image based on the `nginx:latest` and ran some commands from it. The dockerfile created can be checked out in the `nginx_with_vim\` directory of this repository.

To build an image, just run `docker build -t docker_username/image_name:tag_name dockerfile_path`

## CMD vs ENTRYPOINT

### CMD

**`CMD`** is a command that can be specified in a **Dockerfile** that will run by default in the container created from it. However, these will not run if the command to run the container gets an argument to run something else.

<details>
<summary>For example, taking the specified docker file below</summary>
  
    FROM ubuntu:latest

    CMD [ "echo", "Hello World" ]
  
</details>

Supposing an image was created from this with the name `hello` and we run the command `docker run --rm hello`, the output will be `Hello World`.

However, if we run `docker run --rm hello echo "Something Else"` the output will be `Something Else`. Moreover, if we run `docker run --rm -it hello bash`, there will be no output and the terminal will be hanging in the container's bash instead. In other words, everything passed after the image name on the `docker run` command will run in the container instead of what has been specified in the Dockerfile.

### ENTRYPOINT

**`ENTRYPOINT`** is used in Dockerfile to specify fixed commands to run in the container, with the option to run that command with additional arguments or specific options. The Dockerfile in the `hello\` directory illustrates this. If the image `hello` is now built from that and a container is created from it without additional arguments, the output will be `Hello World` by default. But if we run `docker run --rm hello "JP"`, the output will be `Hello JP` instead.

So, in order to make sure if something can be passed as argument when creating a container, we can check out the Dockerfile of the image being used. If you don't have the Dockerfile locally, the container registry (e.g. DockerHub) would be a great place to start your search.

💡 **Note:** It is common to make a `.sh` file to be set as the entrypoint of a Dockerfile. In these cases, if something is required to be passed as an argument to that entrypoint or something else to run besides it, the `.sh` file must end with `exec "$@"`. More explanation can be found [here](https://unix.stackexchange.com/questions/466999/what-does-exec-do) and [also here](https://stackoverflow.com/questions/39082768/what-does-set-e-and-exec-do-for-docker-entrypoint-scripts).

## Publishing an image on DockerHub

1. Build your image `docker build -t docker_username/image_name:tag_name dockerfile_path`
2. create account on dockerhub
3. `docker login`
4. `docker push docker_username/image_name`

## Networks

Type command `docker network` to check out network management commands Docker have available.

* connect     Connect a container to a network
* create      Create a network
* disconnect  Disconnect a container from a network
* inspect     Display detailed information on one or more networks
* ls          List networks
* prune       Remove all unused networks
* rm          Remove one or more networks

### Bridge

Bridge networks are the most commonly network type, and it enables a container to easily communicate with another one.
Let's create two detached containers from the `bash` image and inspect the bridge network with them running.

```bash
docker run -d -it --name ubuntu1 bash
docker run -d -it --name ubuntu2 bash
docker network inspect bridge
```

<details>
<summary>This outputs a <code>json</code> string, and its <code>"Containers"</code> key, we can check out the containers just created: </summary>

    "Containers": {
            "20d389feee553ff326ec982ce50bf2a93d8d69ddf7eccb5f36c6b5d5347d42a4": {
                "Name": "ubuntu1",
                "EndpointID": "e59aebb3189a30269acbbe9bd13717eea1d895f2854a68b44caa72a44f6feac4",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            },
            "907f035b0a88ea14c0a5f0ba4b2267478f6b96b71b4187a87bf9fca972f9e220": {
                "Name": "ubuntu2",
                "EndpointID": "c615d5d16310e682254a58c3d435d8458e16e30a2da6e34fda02b0b2c16e2e76",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16",
                "IPv6Address": ""
            }
        }
	
</details>

Knowing the containers' ip addresses, it is now possible to attach the terminal to one of them in ping the other, like this:

```bash
bash-5.2# ping 172.17.0.3
PING 172.17.0.3 (172.17.0.3): 56 data bytes
64 bytes from 172.17.0.3: seq=0 ttl=64 time=0.062 ms
64 bytes from 172.17.0.3: seq=1 ttl=64 time=0.047 ms
64 bytes from 172.17.0.3: seq=2 ttl=64 time=0.049 ms
```

However, `ubuntu1` does not have name to ip resolution yet. So it is not possible to run `ping ubuntu2` for example. We'll solve this by manually creating a bridge network:

```bash
$ docker network create --driver bridge my_network
69336ad20db2a75b6a97a6fe778a7a9773322187bcc7d8b528a94b9e53d6ed6c
```

After that, we can recreate the `ubuntu1` and `ubuntu2` bash containers, this time setting it to the `my_network` we created just now. After that, we'll attach the terminal to `ubuntu1` and ping ubuntu2, this time using it's name instead of the IP address.

```bash
$ docker run -dit --name ubuntu1 --network my_network bash
a4fc8c72797d5d4eb6323dfd13052440e0814ac4bb94fedbba6c61930fab9bdf
$ docker run -dit --name ubuntu2 --network my_network bash
f5acca00a1c9f5ddaea6b79ba2bb912cec4e67d71b3dd2d340060a2f461c172b
$ docker exec -it ubuntu1 bash
bash-5.2# ping ubuntu2
PING ubuntu2 (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.074 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.056 ms
64 bytes from 172.18.0.2: seq=2 ttl=64 time=0.051 ms
```

On the other hand, if we now create an `ubuntu3` bash container with no network options, it'll be put by default in the `bridge` network instead of `my_network`. Because of this, it won't be able to ping neither `ubuntu1` or `ubuntu2`.

To mitigate this, it is possible to set a new network for a container like this:

```bash
$ docker network connect my_network ubuntu3
$ docker exec -it ubuntu3 bash
bash-5.2# ping ubuntu2
PING ubuntu2 (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.057 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.052 ms
64 bytes from 172.18.0.2: seq=2 ttl=64 time=0.051 ms
```

### Host

Host networks merges container's and the host's networks. Which means that a container in a host network is able to access a port in the host's network. In other words, the container and the host machine are in the same network, so it's not necessary to expose a port in the container in order to access it in the host machine.

It is also possible for containers to access ports exposed in the host's network. For example, if outside any docker container, in the host machine, we have a php serving that html file from earlier at the port 8080, we can check it in our browsing by accessing `localhost:8080`. But for the container to reach it, we use the `--add-host` option when running the container and type `host.docker.internal` instead of `localhost`. Like this:

```bash
$ docker run --rm -it --name ubuntu --add-host=host.docker.internal:host-gateway ubuntu bash
root@0928bd00eb14:/# apt-get update
root@0928bd00eb14:/# apt-get install curl -y
root@0928bd00eb14:/# curl http://host.docker.internal:8080
<h1>This is a custom index file made by JP!</h1>
<p>This file will not be lost even if the container is removed</p>
```

### Overlay

Overlay networks are typically used when there is the need to make containers in different host machines to simulate they are in the same network. A relatively common use case for this is the Docker Swarm, which can create a cluster with several containers in order to scale in application horizontally. For these containers to be able to communicate with each other, they need to be in an overlay network.

### MacVLAN

This basically sets a MAC address to a container in order to simulate it as a physical network interface directly connected to the host machine

### None

Containers can run totally isolated with no network at all.

## Practicing

### Installing a framework inside a container

In the `laravel` directory of this repository, there's a Dockerfile in which an image based on `php:7.4-cli` was created. From it, `libzip-dev` was installed and also the `zip` php extension, as well as the composer package manager. The laravel php framework was also installed and a basic project to show the laravel homepage was set to be served in the entrypoint. More details and explanations can be checked out in `laravel/Dockerfile`.

### Creating a Node.js application without Node in the host machine

For this small project a `node` folder was created and everything was ran from inside it
<details><summary>Along with other options, a <code>node:15</code> container was created running bash with the port <code>3000</code> exposed and mount the <code>node</code> folder mounted at <code>/usr/src/app</code></summary><code>docker run --rm -it -v $(pwd)/:/usr/src/app -p 3000:3000 node:15 bash</code></details>
<details><summary>Then, the some npm commands to generate an initial project and install the npm express package</summary>
	
	npm init -y
	npm install express --save
	
</details>

After that, a sample `index.js` was created and the command `node index.js` was ran.

The result of these steps is that a `node.js` project is running inside a container, even though it is not installed in the host machine. However, we to not have a Dockerfile or an image created for this yet, which is actually quite simple. Just check out the Dockerfile created in the `node` folder.
Also, a `Dockerfile.prod` was created in the same `node` folder, considering a case where the node files didn't exist before. To build an image with this `Dockerfile.prod` instead of the `Dockerfile` tha is used by default, add a `-f file_name` option at the end of the build command, like this: `docker build -t jpaldi/hello-express node/ -f node/Dockerfile.prod`

## Optimizing images

### Multistage Building

[Docker documentation](https://docs.docker.com/build/building/multi-stage/) has a blog post discussing about the challenges of building images keeping its size down. It was common to use a builder pattern, which consists in keeping more than one Dockerfile in a project, one with everything needed for development, and a slimmed-down one to use for production, which only contained your application and exactly what was needed to run it.
In this course, we created a `Dockerfile.prod` in the `laravel` directory as an example of a multi-stage build, which is less failure-prone and easier to maintain, besides reducing the number of images to be maintained and taking space.
In this repository, both Dockerfiles were kept for comparison purposes. After building the new multi-stage image and naming it as jpaldi/laravel:prod (`docker build -t jpaldi/laravel:prod laravel -f laravel/Dockerfile.prod`), here are the current laravel docker images and their sizes:

```bash
$ docker images | grep laravel
jpaldi/laravel          prod      eba7a3cc0f82   3 minutes ago   140MB
jpaldi/laravel          latest    b810b65df89b   19 hours ago    554MB
```
