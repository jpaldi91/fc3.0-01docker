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
