# ROS 2 Humble base (Ubuntu 22.04)
FROM ros:humble-ros-base

SHELL ["/bin/bash", "-c"]

# System deps: vcs import, colcon, udev/usb tools, pip for bluerobotics-ping
RUN apt-get update && apt-get install -y \
    git \
    vim \
    python3-pip \
    python3-vcstool \
    python3-colcon-common-extensions \
    udev \
    usbutils \
 && pip3 install --no-cache-dir bluerobotics-ping \
 && rm -rf /var/lib/apt/lists/*

# Copy super-repo into image (keeps GHCR build behavior same as before)
COPY . /opt/barracuda-sonar

WORKDIR /opt/barracuda-sonar

# Run entrypoint on container start (same pattern as old)
CMD ["/bin/bash", "/opt/barracuda-sonar/entrypoint.sh"]
