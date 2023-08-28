FROM introlab3it/rtabmap_ros:foxy

ENV MISS_WS=/miss_ws


RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential \
        ros-foxy-gazebo-plugins \
        ros-foxy-gazebo-ros-pkgs \
        ros-foxy-rviz2 \
        python3-colcon-common-extensions \
        gcc \
        g++ \
        ros-foxy-xacro \
        ros-foxy-robot-state-publisher \
        ros-foxy-teleop-twist-keyboard \
        ros-foxy-robot-localization \
        ros-foxy-nav2* \
        git \
        nano


RUN mkdir -p /${MISS_WS}/src

WORKDIR ${MISS_WS}
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install' && \ 
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \ 
    echo "source $ALBOT_WS/install/setup.bash" >> /root/.bashrc 

COPY ./miss_entrypoint.sh /miss_entrypoint.sh

RUN chmod +x /miss_entrypoint.sh
ENTRYPOINT [ "/miss_entrypoint.sh" ]


CMD ["bash"]