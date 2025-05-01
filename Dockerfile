# Base image for ROS Noetic on Ubuntu 20.04 Focal
FROM ros:noetic-ros-base-focal


# Install dependencies for the sonar and update other tools
RUN apt-get update && apt-get install -y \
    git \
    vim \
    python3-pip \
    udev \
    usbutils \
    && pip install bluerobotics-ping \
    && rm -rf /var/lib/apt/lists/*

COPY . /opt/barracuda-sonar

# Set working directory
WORKDIR /opt

# Source the workspace on container start
CMD ["/bin/bash", "/opt/barracuda-sonar/entrypoint.sh"]
