# Bài Tập Thực Hành Tổng Hợp: Triển khai Hệ thống E-Commerce lên VPS

## Danh sách tệp tin
- `docker-compose.yml`: Định nghĩa 2 dịch vụ `backend` (`nginxdemos/hello` ánh xạ cổng `80:80`) và `db` (`postgres:15-alpine`).
- `deploy-vps.sh`: Tập hợp toàn bộ lệnh cấu hình user `deploy`, bật tường lửa UFW (cổng 22, 80), cài đặt Docker và khởi chạy hệ thống.

## Các bước bảo mật SSH thực hiện bổ sung
1. Trên máy cá nhân: `ssh-keygen -t rsa -b 4096` và `ssh-copy-id deploy@<IP_CUA_VPS>`.
2. Trên VPS (`/etc/ssh/sshd_config`): đặt `PermitRootLogin no` và `PasswordAuthentication no`, sau đó chạy `sudo systemctl restart ssh`.
3. Truy cập trình duyệt `http://<IP_CUA_VPS>` để kiểm chứng trang demo Nginx hoạt động.
