
#!/bin/bash

set -Eeuo pipefail

# ==========================================
# Backend EC2 Server Setup Script
# Project: AWS_Fproject
# OS: Amazon Linux 2023
# SDK: .NET 10
# ==========================================

# Logging setup
LOG_DIR="$HOME/deployment-logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/backend-setup-$(date +%Y-%m-%d_%H-%M-%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Logging function
log() {
    echo "[$(date '+%F %T')] $*"
}

# Error handling
trap 'log "ERROR: Setup failed near line $LINENO. Check the log: $LOG_FILE"; exit 1' ERR

log "=========================================="
log "Starting backend EC2 server setup"
log "=========================================="

# Step 1: Update system packages
log "Step 1: Updating system packages"
sudo dnf update -y

# Step 2: Install Git and required utilities
log "Step 2: Installing Git and utilities"
sudo dnf install -y git curl-minimal tar gzip

# Step 3: Download Microsoft's official .NET installer
log "Step 3: Downloading Microsoft's .NET installer"
curl -fsSL https://dot.net/v1/dotnet-install.sh \
    -o /tmp/dotnet-install.sh

# Step 4: Install the .NET 10 SDK
log "Step 4: Installing .NET 10 SDK"
sudo mkdir -p /usr/share/dotnet

sudo bash /tmp/dotnet-install.sh \
    --channel 10.0 \
    --install-dir /usr/share/dotnet

# Step 5: Configure the dotnet command
log "Step 5: Configuring the dotnet command"
sudo ln -sfn /usr/share/dotnet/dotnet /usr/local/bin/dotnet

# Step 6: Verify Git
log "Step 6: Verifying Git"
git --version

# Step 7: Verify .NET SDK
log "Step 7: Verifying .NET SDK"
dotnet --list-sdks

# Step 8: Verify installed .NET runtimes
log "Step 8: Verifying .NET runtimes"
dotnet --list-runtimes

# Step 9: Create application deployment directory
log "Step 9: Creating application deployment directory"
sudo mkdir -p /var/www/employee-api
sudo chown "$USER":"$USER" /var/www/employee-api

log "Application directory permissions configured"
ls -ld /var/www/employee-api

log "=========================================="
log "Backend server preparation completed successfully"
log "Log file: $LOG_FILE"
log "=========================================="
