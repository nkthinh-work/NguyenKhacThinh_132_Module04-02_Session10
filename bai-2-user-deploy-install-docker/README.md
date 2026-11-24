# Bài tập 2: Tạo User Deploy và Cài đặt Docker

Danh sách lệnh chi tiết nằm trong file [`commands.sh`](./commands.sh).

## Kiểm chứng dưới quyền user `deploy`
```bash
su - deploy
docker --version
docker compose version
docker run --rm hello-world
```
