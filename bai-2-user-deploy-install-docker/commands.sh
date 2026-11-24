#!/bin/bash
# ==========================================
# Bài tập 2: Tạo User deploy & Cài đặt Docker
# Thực thi dưới quyền root trên Ubuntu 22.04
# ==========================================

# 1. Cập nhật hệ thống
apt update && apt upgrade -y

# 2. Tạo user 'deploy' và cấp quyền sudo
adduser --gecos "" deploy
usermod -aG sudo deploy

# 3. Cài đặt Docker Engine & Docker Compose Plugin (Official Script)
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh

# 4. Thêm user 'deploy' vào group 'docker' để chạy Docker không cần sudo
usermod -aG docker deploy

# 5. Kích hoạt Docker khởi động cùng hệ thống
systemctl enable docker
systemctl start docker

# 6. Chuyển sang user 'deploy' và kiểm tra phiên bản
su - deploy -c "docker --version && docker compose version"
