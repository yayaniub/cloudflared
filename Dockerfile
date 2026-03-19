# 基础镜像

FROM alpine:latest

# 设置工作目录

WORKDIR /appnb

# 复制当前目录下的所有内容到容器的工作目录

COPY ./ /appnb

# 设置应用和 Cloudflared 的执行权限

RUN chmod +x /appnb/start.sh

# 使用 sh 执行启动脚本

CMD ["/bin/sh", "/appnb/start.sh"]