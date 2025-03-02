#!/bin/bash

# 设置颜色
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 开始安装 NapthaAI 节点...${NC}"

# 更新系统并安装必要依赖
echo -e "${GREEN}🔄 更新系统软件包...${NC}"
apt update && apt upgrade -y
echo -e "${GREEN}✅ 系统更新完成！${NC}"

echo -e "${GREEN}📦 安装 Docker、Docker Compose、Git 和 Python3${NC}"
apt install -y docker.io docker-compose git python3 python3-venv python3-pip

# 启动 Docker 并设置开机自启
systemctl start docker
systemctl enable docker
echo -e "${GREEN}✅ Docker 安装完成！${NC}"

# 克隆 NapthaAI 节点仓库
echo -e "${GREEN}🌍 克隆 NapthaAI 节点仓库...${NC}"
git clone https://github.com/NapthaAI/node.git ~/naptha-node
cd ~/naptha-node || exit

# 复制默认环境变量配置
echo -e "${GREEN}⚙️ 配置环境变量...${NC}"
cp .env.example .env

# 启动 NapthaAI 节点
echo -e "${GREEN}🚀 启动 NapthaAI 节点...${NC}"
docker-compose up -d

# 完成安装
echo -e "${GREEN}✅ NapthaAI 节点安装完成！${NC}"
echo -e "${GREEN}📍 访问地址: http://$(hostname -I | awk '{print $1}'):7001${NC}"
