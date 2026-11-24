# Bài tập 1: Khởi tạo và kết nối VPS Ubuntu 22.04 LTS

## 1. Thông số khởi tạo VPS (Cloud Provider: AWS EC2 / DigitalOcean / Google Cloud)
- **Hệ điều hành (OS):** Ubuntu Server 22.04 LTS (64-bit x86)
- **Cấu hình tối thiểu (Free Tier / Staging):** 1 vCPU, 1 GB RAM, 20 GB SSD
- **Mạng & Security Group:** Mở cổng TCP `22` (SSH) cho phép truy cập từ IP quản trị

## 2. Câu lệnh kết nối SSH từ máy cá nhân
```bash
# Trường hợp đăng nhập bằng mật khẩu (DigitalOcean / Vultr)
ssh root@<VPS_PUBLIC_IP>

# Trường hợp dùng file khóa .pem (AWS EC2 / GCP)
chmod 400 ~/.ssh/staging-key.pem
ssh -i ~/.ssh/staging-key.pem ubuntu@<VPS_PUBLIC_IP>

# Kiểm tra thông tin hệ điều hành và tài nguyên sau khi đăng nhập thành công
lsb_release -a
uname -a
free -h && df -h
```
