
#!/bin/bash

set -Eeuo pipefail

# Logging setup
LOG_DIR="$HOME/deployment-logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/backend-setup-$(date +%Y-%m-%d_%H-%M-%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "[$(date '+%F %T')] $*"
}

trap 'log "ERROR: Setup failed near line $LINENO"; exit 1' ERR

log "Starting backend EC2 server setup"

# Update system packages
log "Updating Amazon Linux packages"
sudo dnf update -y

# Install Git and required utilities
log "Installing Git and utilities"
sudo dnf install -y git curl tar gzip

# Install the Microsoft .NET 10 SDK
log "Adding Microsoft package repository"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo dnf install -y \
    https://packages.microsoft.com/config/rhel/9/packages-microsoft-prod.rpm

log "Installing .NET 10 SDK"
sudo dnf install -y dotnet-sdk-10.0

# Verify installations
log "Checking Git version"
git --version

log "Checking .NET SDK"
dotnet --list-sdks

log "Checking .NET runtimes"
dotnet --list-runtimes

# Create application deployment directory
log "Creating application directory"
sudo mkdir -p /var/www/employee-api

log "Backend server preparation completed successfully"
log "Log file: $LOG_FILE"
