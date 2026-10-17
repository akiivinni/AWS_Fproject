
#!/bin/bash

set -Eeuo pipefail

LOG_DIR="$HOME/deployment-logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/frontend-setup-$(date +%Y-%m-%d_%H-%M-%S).log"

exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "[$(date '+%F %T')] $*"
}

trap 'log "ERROR: Setup failed near line $LINENO"; exit 1' ERR

log "Starting frontend server setup"

log "Updating system packages"
sudo dnf update -y

log "Installing Nginx and Git"
sudo dnf install -y nginx git

log "Enabling and starting Nginx"
sudo systemctl enable --now nginx

log "Verifying Nginx"
sudo systemctl is-active nginx

log "Verifying Git"
git --version

log "Frontend setup completed"
log "Log file: $LOG_FILE"
