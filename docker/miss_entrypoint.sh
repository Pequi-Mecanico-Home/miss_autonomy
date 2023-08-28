#!/bin/bash

source /opt/ros/foxy/setup.bash

colcon build --symlink-install

source install/setup.bash

# export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$ALBOT_WS/src/aws-robomaker-small-warehouse-world/models/:$ALBOT_WS/src/albot-description/models/
chmod 777 -R /${MISS_WS}/src

exec "$@"