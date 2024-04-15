FROM introlab3it/rtabmap_ros:humble

ENV MISS_WS=/miss_ws
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA 

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential \
        ros-humble-gazebo-plugins \
        ros-humble-gazebo-ros-pkgs \
        ros-humble-rviz2 \
        python3-colcon-common-extensions \
        gcc \
        g++ \
        ros-humble-xacro \
        ros-humble-robot-state-publisher \
        ros-humble-teleop-twist-keyboard \
        ros-humble-robot-localization \
        ros-humble-nav2* \
        ros-humble-velodyne-gazebo-plugins \
        ros-humble-rqt-tf-tree \
        ros-humble-swri-console \
        git \
        nano


RUN mkdir -p /${MISS_WS}/src

RUN git clone https://github.com/osrf/gazebo_models.git /tmp/gazebo_models
RUN cp -r /tmp/gazebo_models/* /usr/share/gazebo-11/models/ && rm -rf /tmp/gazebo_models

WORKDIR ${MISS_WS}
COPY . ${MISS_WS}/src
RUN rosdep update --rosdistro=humble && \
    rosdep install --from-path src --ignore-src -r -y

RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install' && \ 
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \ 
    echo "source $MISS_WS/install/setup.bash" >> /root/.bashrc 

COPY ./miss_entrypoint.sh /miss_entrypoint.sh

RUN chmod +x /miss_entrypoint.sh
ENTRYPOINT [ "/miss_entrypoint.sh" ]


CMD ["bash"]