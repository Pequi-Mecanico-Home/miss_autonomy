#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check if NVIDIA runtime is available in Docker
CHECK_RUNTIME=$(docker info --format '{{.Runtimes.nvidia}}')

if [ "$CHECK_RUNTIME" = "<no value>" ]; then
  echo "Running with Integrated Graphics support runtime"
  RUNTIME='--devices /dev/dri '
else
  echo "Running with NVIDIA runtime"
  RUNTIME='--nvidia '
fi

rocker $RUNTIME--x11 \
  --name miss-simulation \
  --network host \
  --oyr-run-arg " -v $SCRIPT_DIR:/miss_ws/src:rw" \
  miss_simulation:humble-2024-v1 bash