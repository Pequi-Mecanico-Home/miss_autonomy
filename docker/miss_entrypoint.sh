#!/bin/bash

source /opt/ros/${ROS_DISTRO}/setup.bash

colcon build --symlink-install

source install/setup.bash

#Script to copy model files do Gazebo Path so it can run third-party worlds
source /miss_ws/src/miss_worlds/setup_models.sh

exec "$@"