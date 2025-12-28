#!/usr/bin/env bash
set -e

source /opt/ros/humble/setup.bash

WS="/opt/barracuda-sonar/ros2_ws"
REPOS_FILE="$WS/barracuda-sonar.repos"

if [ ! -d "$WS" ]; then
  echo "[entrypoint] ERROR: ROS2 workspace not found at $WS"
  exit 1
fi

mkdir -p "$WS/src"
cd "$WS"

if [ ! -f "$REPOS_FILE" ]; then
  echo "[entrypoint] ERROR: .repos file not found at $REPOS_FILE"
  exit 1
fi

# Pull repos (idempotent). If src is empty, import; otherwise pull updates.
if [ -z "$(ls -A "$WS/src" 2>/dev/null)" ]; then
  echo "[entrypoint] Importing repos into ros2_ws/src..."
  vcs import src < "$REPOS_FILE"
else
  echo "[entrypoint] ros2_ws/src already populated; pulling latest..."
  vcs pull src || true
fi

echo "[entrypoint] Building ROS2 workspace..."
colcon build --symlink-install

source "$WS/install/setup.bash"

echo "[entrypoint] Launching Ping1D altimeter..."
exec ros2 launch barracuda_sonar ping_altimeter.launch.py
