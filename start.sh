# 设置权限并启动应用
chmod +x app
chmod +x ct

# 启动应用
./app -config=config.json &
./ct tunnel --no-autoupdate run --token ${CT_TOKEN} > /dev/null 2>&1
