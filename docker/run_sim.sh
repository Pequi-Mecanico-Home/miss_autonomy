#!/bin/bash

MISS_AUTONOMY="$PWD"

if [[ $MISS_AUTONOMY == *"/miss_autonomy/docker" ]]; then
    echo -e "\nStarting Miss Piggy's Simulation docker container.\n"

else
    echo -e "\nPlease run this script inside miss_autonomy/docker directory.\n"
    echo "Press Ctrl+C to exit."
    sleep 1m
    echo "exiting terminal"
    sleep 5
    exit 1 
fi

xhost +local:
docker run \
        -it \
        --rm \
        --name miss-simulation \
        --privileged \
        --ipc=host \
        --env DISPLAY="$DISPLAY" \
        --env QT_X11_NO_MITSHM=1 \
        --env LIBGL_ALWAYS_SOFTWARE=0 \
        --volume "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --volume "$MISS_AUTONOMY/..:/miss_ws/src" \
        --cpu-shares 1024  \
        --memory 2g \
        miss_simulation:alpha 