# xSTUDIO Docker Build 🐳

This script allows you to build xSTUDIO a Docker image and copies files from the container to the current directory.

## Requirements

- Docker must be installed on your system.

## Usage

To use the script, run it with the following command:

./script.sh [centos7|rockylinux8|rockylinux9] [qt-email] [qt-password]


- The first argument is the choice of platform among `centos7`, `rockylinux8` and `rockylinux9`.
- The `qt-email` and `qt-password` arguments are optional and only required for the `centos7` and `rockylinux8` platforms.

You can also display a help message by running the script with the `--help` or `-h` argument:

./script.sh --help


## Example

Here is an example of how to use the script to build an image for the `centos7` platform with the `qt-email` and `qt-password` arguments:

./script.sh centos7 myemail@example.com mypassword


This will build a Docker image with the tag `myimage:centos7`, launch a container from it and copy files from the `/usr/local/build` directory in the container to the current directory.

## Enjoy! 🎉
This README file provides an overview of the script’s requirements and usage, as well as an example of how to use it with the centos7 platform and the qt-email and qt-password arguments. It also includes some emojis to make it more fun and engaging.