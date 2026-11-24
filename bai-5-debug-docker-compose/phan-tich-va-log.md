# Bài tập 5: Phân tích và sửa lỗi triển khai Docker Compose (`Order Service`)

## 1. Log lỗi thu được từ bản gốc (`docker compose logs order-service`)
```text
order-service  | org.postgresql.util.PSQLException: Connection to localhost:5432 refused. Check that the hostname and port are correct and that the postmaster is accepting TCP/IP connections.
order-service  | 	at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:342)
order-service  | Caused by: java.net.ConnectException: Connection refused
order-service  | 	at java.base/sun.nio.ch.Net.pollConnect(Native Method)
```

## 2. Phân tích nguyên nhân gốc rễ (Root Cause)
- Mỗi container trong Docker Compose hoạt động như một máy chủ độc lập với **Network Namespace** riêng biệt và địa chỉ IP nội bộ riêng trong mạng bridge mặc định của Compose.
- Khi cấu hình `SPRING_DATASOURCE_URL: jdbc:postgresql://localhost:5432/quickbite_db`, địa chỉ `localhost` (`127.0.0.1`) bên trong container `order-service` trỏ về **chính bản thân container `order-service`** chứ không phải máy chủ host hay container `order-db`. Vì container `order-service` không chạy PostgreSQL ở cổng 5432 nên kết nối bị từ chối ngay lập tức (`Connection refused`).
- Docker Compose cung cấp **Embedded DNS Server** nội bộ tự động phân giải tên `service` thành địa chỉ IP của container tương ứng trong cùng network. Ngoài ra, thiếu `depends_on` (kèm `healthcheck`) khiến `order-service` có thể khởi động xong trước khi PostgreSQL sẵn sàng nhận kết nối.

## 3. Các điểm đã khắc phục trong `docker-compose.fixed.yml`
1. Đổi `localhost` thành tên service database `order-db`:
   `SPRING_DATASOURCE_URL: jdbc:postgresql://order-db:5432/quickbite_db`
2. Bổ sung `depends_on` với điều kiện `service_healthy` và `healthcheck` (`pg_isready`) cho `order-db` để đảm bảo PostgreSQL hoàn tất khởi tạo trước khi `order-service` kết nối.

## 4. Log xác nhận kết nối thành công sau khi sửa
```text
order-db       | database system is ready to accept connections
order-service  | HikariPool-1 - Starting...
order-service  | HikariPool-1 - Added connection org.postgresql.jdbc.PgConnection@4b2c5e02
order-service  | HikariPool-1 - Start completed.
order-service  | Started OrderServiceApplication in 3.412 seconds (process running for 3.985)
```
