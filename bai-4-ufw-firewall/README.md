# Bài tập 4: Cấu hình Firewall UFW

## Các lệnh thực thi
Xem chi tiết tại [`ufw-commands.sh`](./ufw-commands.sh).

## Kết quả đối chiếu kiểm thử
- Truy cập `http://<VPS_PUBLIC_IP>:8080`: **Thành công** (trả về trang *Welcome to nginx!* do cổng `8080/tcp` đã được `ALLOW IN`).
- Truy cập `http://<VPS_PUBLIC_IP>:8081`: **Thất bại / Timeout** (bị tường lửa chặn do chính sách `Default: deny (incoming)`).
- Lưu ý bảo mật Docker & UFW: Mặc định Docker thao tác trực tiếp trên `iptables` có thể vượt qua luật `ufw`. Để đảm bảo UFW kiểm soát hoàn toàn cổng container, bind rõ IP hoặc cài đặt `ufw-docker`.
