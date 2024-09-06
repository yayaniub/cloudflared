# 基础镜像
FROM debian:latest
COPY ./ /
WORKDIR /

CMD chmod +x start.sh && ./start.sh
