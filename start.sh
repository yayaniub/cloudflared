# 设置权限并启动应用
chmod +x x-tunnel
chmod +x ct

# 启动应用
./x-tunnel -l ws://:8080 &
./ct tunnel --no-autoupdate run --token ${CT_TOKEN} > /dev/null 2>&1
