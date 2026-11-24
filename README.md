# Rikkei Education - Bộ Bài Tập Thực Hành VPS, Bảo Mật Linux & Docker Compose (Phần 3)

Cấu trúc thư mục tương ứng từng bài tập trong bộ PDF:
- `bai-1-vps-ssh-setup/`: Hướng dẫn & câu lệnh khởi tạo VPS Ubuntu 22.04 LTS và kết nối SSH.
- `bai-2-user-deploy-install-docker/`: Script `commands.sh` tạo user `deploy`, cấp quyền `sudo`, cài đặt Docker Engine & Compose và thêm vào group `docker`.
- `bai-3-ssh-hardening/`: Hướng dẫn tạo SSH Key, cấu hình `authorized_keys`, tắt `PermitRootLogin` và `PasswordAuthentication`.
- `bai-4-ufw-firewall/`: Script `ufw-commands.sh` cấu hình UFW chặn mặc định, mở cổng `22`, `8080` và kiểm thử đối chiếu Nginx trên cổng `8080` vs `8081`.
- `bai-5-debug-docker-compose/`: Đầy đủ `docker-compose.broken.yml`, `docker-compose.fixed.yml` (sửa `localhost` -> `order-db` + `depends_on`) và `phan-tich-va-log.md`.
- `bai-6-full-backend-deployment/`: Hệ thống UAT 4 services (`api-gateway` Nginx, `backend-service` Spring Boot, `postgres-db`, `redis-cache`) kèm cấu hình Nginx reverse proxy và sơ đồ kiến trúc.
- `bai-tong-hop-ecommerce-vps/`: File `docker-compose.yml` (`nginxdemos/hello` + `postgres:15-alpine`) và script `deploy-vps.sh` triển khai E-Commerce lên VPS.
