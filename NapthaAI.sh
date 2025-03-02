#!/bin/bash

echo "🚀 开始安装 NapthaAI 节点..."
apt update && apt install -y wget curl docker.io docker-compose git
git clone https://github.com/NapthaAI/node.git ~/naptha-node
cd ~/naptha-node
cp .env.example .env
docker-compose up -d
echo "✅ NapthaAI 节点已安装！"
