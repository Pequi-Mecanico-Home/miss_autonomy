#!/bin/bash

source /opt/ros/${ROS_DISTRO}/setup.bash

colcon build --symlink-install

source install/setup.bash

exec "$@"