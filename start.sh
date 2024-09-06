export PORT=${PORT-80}
export id=${id-cb2ef9cb-fc3a-4f42-a206-0a59919a38d6}
export CT_TOKEN=${CT_TOKEN-eyJhIjoiZjVjZjM0ZWI4ODIyMDVmNjhhN2IyNWRkMGE0Mjk5NGEiLCJ0IjoiOTAwNWQ2NDctMWM1Yi00NTc4LTgwNDMtOTJiOTA5MzcyNWYxIiwicyI6Ik1tRXdPV0ZpWXpFdE5qUm1ZUzAwWVRrMkxUazBaVEl0WW1Vd016Sm1NR05qWWpKaCJ9}

# 生成 config.json 文件
cat <<EOF > config.json
{
    "log": {
        "loglevel": "none"
    },
    "inbounds": [
        {
            "port": '$PORT',
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "'$id'",
                        "flow": "xtls-rprx-vision"
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": 3001
                    },
                    {
                        "path": "/trojan",
                        "dest": 3002
                    },
                    {
                        "path": "/vmess",
                        "dest": 3003
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp"
            }
        },
        {
            "port": 3001,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "'$id'"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        },
        {
            "port": 3002,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "'$id'"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "path": "/trojan"
                }
            }
        },
        {
            "port": 3003,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "'$id'"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "path": "/vmess"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# 设置权限并启动应用
chmod +x app
chmod +x ct

# 启动应用
./app -config=config.json &
./ct tunnel --no-autoupdate run --token ${CT_TOKEN}
