#!/bin/bash
# ==========================================
# Bài tập 4: Cấu hình Firewall UFW trên Ubuntu
# ==========================================

# 1. Thiết lập chính sách mặc định: chặn toàn bộ kết nối đến, cho phép kết nối đi
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. Mở cổng 22 (SSH) TRƯỚC KHI kích hoạt UFW để tránh mất kết nối
sudo ufw allow 22/tcp

# 3. Mở cổng 8080 (TCP) cho ứng dụng Backend
sudo ufw allow 8080/tcp

# 4. Kích hoạt tường lửa UFW
sudo ufw --force enable

# 5. Kiểm tra trạng thái chi tiết
sudo ufw status verbose

# 6. Chạy 2 container Nginx tại cổng 8080 (được mở) và 8081 (bị chặn) để đối chiếu
docker run -d --name nginx-8080 -p 8080:80 nginx:alpine
docker run -d --name nginx-8081 -p 8081:80 nginx:alpine
