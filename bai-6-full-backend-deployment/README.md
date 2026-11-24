# Bài tập 6: Triển khai toàn diện Hệ thống Backend lên VPS (UAT)

## 1. Kiến trúc hệ thống & Luồng hoạt động
```
[Client / Browser]
        │  HTTP (Port 80 - Mở trên UFW)
        ▼
┌───────────────────────────────────────────┐
│  api-gateway (Nginx Reverse Proxy :80)    │
└───────────────────────────────────────────┘
        │  Internal Docker Network (quickbite-net)
        ▼
┌───────────────────────────────────────────┐
│  backend-service (Spring Boot :8080)      │
└───────┬───────────────────────────┬───────┘
        │ JDBC :5432                │ RESP :6379
        ▼                           ▼
┌───────────────────┐     ┌─────────────────┐
│   postgres-db     │     │   redis-cache   │
│ (postgres:15)     │     │ (redis:7)       │
└───────────────────┘     └─────────────────┘
```

- **Lớp biên (Edge / API Gateway):** Container `api-gateway` (Nginx) là dịch vụ duy nhất ánh xạ cổng `80:80` ra Internet. Mọi request HTTP đi vào cổng 80 đều được reverse proxy chuyển tiếp nội bộ tới `http://backend-service:8080`.
- **Lớp ứng dụng (Backend):** Container `backend-service` không mở cổng trực tiếp ra ngoài (`expose: 8080`), giúp ẩn hoàn toàn ứng dụng khỏi truy cập trực tiếp bên ngoài.
- **Lớp dữ liệu (Data & Cache):** `postgres-db` và `redis-cache` giao tiếp qua mạng nội bộ `quickbite-net`, dữ liệu được lưu bền vững qua Named Volumes (`pg_uat_data`, `redis_uat_data`).

## 2. Quy trình triển khai & Kiểm chứng trên VPS
```bash
# 1. Mở cổng 80 trên tường lửa UFW
sudo ufw allow 80/tcp
sudo ufw reload

# 2. Kéo image mới nhất và khởi chạy hệ thống ở chế độ nền
docker compose pull
docker compose up -d

# 3. Kiểm tra trạng thái container và gọi API qua API Gateway
docker compose ps
curl -i http://localhost/actuator/health
```
