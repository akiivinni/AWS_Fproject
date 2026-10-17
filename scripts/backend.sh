
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

# Step 3: Add Microsoft's package repository
log "Step 3: Adding Microsoft package repository"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo dnf install -y \
    https://packages.microsoft.com/config/rhel/9/packages-microsoft-prod.rpm

# Step 4: Install .NET 10 SDK
log "Step 4: Installing .NET 10 SDK"
sudo dnf install -y dotnet-sdk-10.0

# Step 5: Verify Git installation
log "Step 5: Verifying Git"
git --version

# Step 6: Verify .NET SDK installation
log "Step 6: Verifying .NET SDK"
dotnet --list-sdks

# Step 7: Verify installed .NET runtimes
log "Step 7: Verifying .NET runtimes"
dotnet --list-runtimes

# Step 8: Create application deployment directory
log "Step 8: Creating application deployment directory"
sudo mkdir -p /var/www/employee-api

# Step 9: Set directory ownership for ec2-user
sudo chown "$USER":"$USER" /var/www/employee-api

log "Application directory permissions configured"

# Step 10: Display deployment directory details
ls -ld /var/www/employee-api

log "=========================================="
log "Backend server preparation completed successfully"
log "Log file: $LOG_FILE"
log "=========================================="
