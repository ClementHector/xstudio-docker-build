#!/bin/bash

# Colors for terminal
RST='\033[0m'             # Text Reset
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIRed='\033[1;91m'        # Red

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo -e "${BIRed}!!! Docker is not installed. Please install it before continuing.${RST}"
    exit 1
fi

# Parse arguments
platform=""
qt_email=""
qt_password=""
destination_path="$1/build"
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -h|--help)
        echo "Usage: $0 [centos7|rocky8|rocky9] [--qt-email|-m qt-email] [--qt-password|-pw qt-password] [--path|-p destination_path] [--version|-v xstudio_version]]"
        exit 0
        ;;
        centos7|rocky8|rocky9)
        platform="$1"
        shift
        ;;
        --qt-email|-m)
        qt_email="$2"
        shift
        shift
        ;;
        --qt-password|-pw)
        qt_password="$2"
        shift
        shift
        ;;
        --path|-p)
        destination_path="$2"
        shift
        shift
        ;;
        --version|-v)
        xstudio_version="$2"
        shift
        shift
        ;;
        *)
        shift
        ;;
    esac
done

# Check platform choice
if [ "$platform" != "centos7" ] && [ "$platform" != "rocky8" ] && [ "$platform" != "rocky9" ]
then
    echo $qt_email
    echo $platform
    echo -e "Please choose a platform among ${BIYellow}centos7${RST}, ${BIYellow}rocky8${RST} and ${BIYellow}rocky9${RST}."
    exit 1
fi

# Check qt-email and qt-password arguments for centos7
if [ "$platform" == "centos7" ]
then
    if [ -z "$qt_email" ] || [ -z "$qt_password" ]
    then
        echo -e "Please provide your qt ${BIYellow}email${RST} and ${BIYellow}password${RST} for the centos7 and rocky8 platforms."
        exit 1
    fi

    # Pass arguments to docker build command using environment variables
    build_args="--build-arg QT_EMAIL=$qt_email --build-arg QT_PASSWORD=$qt_password"
else
    build_args=""
fi
echo $build_args

# Build Docker image
docker build $build_args -t xstudio:$platform  $platform/.
if [ $? -ne 0 ] ; then
    echo $?
    echo -e "${BIRed}/!\ Docker build failed. /!\ ${RST}"
    exit 1
  fi

# Launch container
container_id=$(docker run -d xstudio:$platform)

# Create destination directory if it doesn't exist
rm -rf $destination_path
mkdir -p $destination_path

# Copy files from /usr/local/build directory in container to destination directory
docker cp $container_id:/usr/local/src/xstudio/build/bin/. $destination_path

# stop and remove container
docker stop $container_id
docker rm $container_id

# Check if copy was successful
if [ $? -eq 0 ]
then
    echo -e "${BIGreen} xSTUDIO have been successfully copied.${RST}"
else
    echo -e "${BIRed}!!! An error occurred while copying files.${RST}"
fi