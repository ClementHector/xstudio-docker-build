# xSTUDIO Docker Build 🐳

This script allows you to build [xSTUDIO](https://github.com/AcademySoftwareFoundation/xstudio)
a Docker image and copies files from the container to the current directory.

## Requirements

- Docker must be installed on your system.

## Usage

To use the script, run it with the following command:

``` bash
/build.sh [centos7|rocky8|rocky9] [--qt-email|-m qt-email] [--qt-password|-pw qt-password]
          [--path|-p destination_path] [--version|-v xstudio_version]]
```

- The first argument is the choice of platform among `centos7`, `rockylinux8` and `rockylinux9`.
- The `qt-email` and `qt-password` arguments are optional and only required for the `centos7`.
- The `version` argument are not yet implemented.

You can also display a help message by running the script with the `--help` or `-h` argument:

``` bash
./build.sh --help
```

## Example

Here is an example of how to use the script to build an image for the `centos7` platform with the `qt-email` and `qt-password` arguments:

./script.sh centos7 -m myemail@example.com -pw mypassword

The qt email and password is required for the centos7. These credentials are for the https://www.qt.io/ website to obtain an open-source license for qt5.

This will build a Docker image with the tag `xstudio:[centos7|rocky8|rocky9]`, launch a container from it and copy files from the `/usr/local/src/xstudio/build/` directory in the container to the current directory.

## Enjoy! 🎉

This README file provides an overview of the script’s requirements and usage.