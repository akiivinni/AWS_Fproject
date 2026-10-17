
#!/bin/bash

set -Eeuo pipefail

# Create a timestamped deployment log
LOG_DIR="$HOME/deployment-logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/backend-setup-$(date +%Y-%m-%d_%H-%M-%S).log"

exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "[$(date '+%F %T')] $*"
}

trap 'log "ERROR: Setup failed near line $LINENO"; exit 1' ERR

log "Starting backend EC2 setup"

# Install Git
log "Installing Git"
sudo dnf install -y git

# Verify Git
git --version

log "Backend server setup completed"
log "Log file: $LOG_FILE"
