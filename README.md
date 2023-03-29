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
