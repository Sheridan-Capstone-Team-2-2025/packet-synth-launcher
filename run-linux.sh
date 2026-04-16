#!/bin/bash

#Packet Synthesizer - Linux Launcher

CONFIG_FILE="./launcher.conf"

# Default image (no prompt)
if [ ! -f "$CONFIG_FILE" ]; then
    echo "IMAGE=dacae/packet-synth" > $CONFIG_FILE
fi

echo "Using IMAGE=$IMAGE"

source $CONFIG_FILE
# Check Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker Engine not installed."
    exit 1
fi

# Start Docker if not running
if ! docker info &> /dev/null; then
    echo "Running Docker..."
    sudo systemctl start docker
    sleep 3
    if ! docker info &> /dev/null; then
        echo "Error: Failed to start Docker. Please launch Docker manually"
        exit 1
    fi
    echo "Docker started successfully."
fi

# Create themes directory if it doesn't exist
if [ ! -d "./themes" ]; then
    mkdir -p ./themes
fi

# First time app setup
if [ ! -f "./config.json" ]; then
    echo ""
    echo "  First time setup - Network configuration"
    echo ""
    echo "Available network interfaces:"
    ip link show | grep -E "^[0-9]+:" | awk '{print "  " $2}' | tr -d ':'
    echo ""
    read -p "Enter network interface name (e.g. eth0, wlan0): " device
    device=${device:-eth0}

    cat > config.json << EOF
{
  "injectionType": "1",
  "device": "${device}",
  "advancedMode": "false"
}
EOF
    echo "config.json created."
    echo ""
fi

# Allow Docker to use the display
xhost +local:docker 2>/dev/null

# Pull and run
echo "Pulling latest image..."
docker pull $IMAGE

echo "Starting Packet Synthesizer..."
docker run --rm \
  -e DISPLAY=$DISPLAY \
  -e NO_AT_BRIDGE=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $(pwd)/themes:/app/themes \
  -v $(pwd)/config.json:/app/config.json \
  --cap-add NET_ADMIN \
  --cap-add NET_RAW \
  --network host \
  $IMAGE
