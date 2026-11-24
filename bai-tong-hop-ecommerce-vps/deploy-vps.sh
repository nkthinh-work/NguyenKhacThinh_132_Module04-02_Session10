#!/bin/bash
# ============================================================
# Script tổng hợp triển khai E-Commerce lên VPS Ubuntu 22.04
# ============================================================

# [Bước 1 - Thực thi với quyền root] Tạo user deploy & cấp sudo
adduser --gecos "" deploy
usermod -aG sudo deploy

# [Bước 2 - Thực thi với quyền root] Cấu hình Firewall UFW
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw --force enable
ufw status verbose

# [Bước 3 - Thực thi với quyền root] Cài đặt Docker Engine & Compose Plugin
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh
usermod -aG docker deploy

# [Bước 4 - Thực thi với user deploy] Khởi chạy hệ thống Docker Compose
su - deploy -c "mkdir -p ~/ecommerce-app && cd ~/ecommerce-app && docker compose up -d && docker compose ps"
