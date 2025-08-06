#!/bin/bash
source /opt/ros/noetic/setup.bash

# Build & Source catkin_ws
cd /opt/barracuda-sonar/catkin_ws
catkin_make
source devel/setup.bash

roslaunch barracuda_sonar barracuda_sonar.launch
