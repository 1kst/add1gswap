#!/bin/bash

# 检查当前系统是否已经存在SWAP
grep -q "swap" /etc/fstab
SWAP_EXISTS=$?

if [ $SWAP_EXISTS -eq 0 ]; then
    echo "Swap已经存在，无需创建新的SWAP分区。"
    exit 1
fi

# 创建SWAP文件
echo "正在创建SWAP文件..."
fallocate -l 2G /swapfile  # 可以根据需要调整SWAP文件的大小
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# 永久挂载SWAP
echo "/swapfile none swap sw 0 0" >> /etc/fstab

echo "SWAP已成功创建并永久挂载。"
