#!/usr/bin/bash
source /opt/ros/noetic/setup.bash

# Build & Source catkin_ws
cd barracuda-sonar/catkin_ws
catkin_make
source devel/setup.bash

exec /bin/bash
