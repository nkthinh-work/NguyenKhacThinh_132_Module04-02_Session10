# Bài tập 3: Tăng cường bảo mật SSH (Key-based Auth & Disable Root Login)

## Bước 1: Tạo cặp khóa SSH (Ed25519 / RSA 4096) trên máy cá nhân (Local)
```bash
ssh-keygen -t ed25519 -C "deploy@quickbite-vps" -f ~/.ssh/id_ed25519_vps
```

## Bước 2: Copy Public Key lên VPS cho user `deploy`
```bash
# Cách 1: Dùng ssh-copy-id (trên Linux/macOS/Git Bash)
ssh-copy-id -i ~/.ssh/id_ed25519_vps.pub deploy@<VPS_PUBLIC_IP>

# Cách 2: Thủ công (trên PowerShell Windows)
type $env:USERPROFILE\.ssh\id_ed25519_vps.pub | ssh deploy@<VPS_PUBLIC_IP> "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

## Bước 3: Kiểm thử đăng nhập bằng SSH Key trước khi khóa mật khẩu
```bash
ssh -i ~/.ssh/id_ed25519_vps deploy@<VPS_PUBLIC_IP>
```

## Bước 4: Cấu hình `/etc/ssh/sshd_config` trên VPS
Mở file `/etc/ssh/sshd_config` bằng quyền sudo (`sudo nano /etc/ssh/sshd_config`) và cập nhật:
```text
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
ChallengeResponseAuthentication no
```
Kiểm tra cú pháp và khởi động lại dịch vụ SSH:
```bash
sudo sshd -t
sudo systemctl restart ssh
```

## Bước 5: Kiểm chứng
```bash
# Kết quả mong đợi: Permission denied (publickey).
ssh root@<VPS_PUBLIC_IP>
```
