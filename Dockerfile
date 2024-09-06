# 基础镜像
FROM debian:latest

# 创建配置目录
RUN mkdir -p /etc/app

# 创建新的应用目录 /appnb
RUN mkdir -p /appnb

# 复制 app 配置文件到容器中
COPY config.json /etc/app/config.json

COPY ct /appnb/ct

# 赋予 ct 可执行权限
RUN chmod +x /appnb/ct

# 将 `app` 文件复制到新的应用目录中
COPY app /appnb/app

# 赋予 `app` 可执行权限
RUN chmod +x /appnb/app

# 暴露应用程序端口
EXPOSE 8080

CMD /appnb/app -c /etc/app/config.json & ct tunnel --no-autoupdate run --token ${CT_TOKEN}
