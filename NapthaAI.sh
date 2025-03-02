#!/bin/bash

# 颜色输出
GREEN="\e[32m"
RESET="\e[0m"

echo -e "${GREEN}🚀 开始安装 NapthaAI 节点...${RESET}"

# 更新系统软件包
echo -e "${GREEN}🔄 更新系统软件包...${RESET}"
apt update && apt upgrade -y

# 安装必要的依赖
echo -e "${GREEN}🔧 安装必备软件 (wget, git, curl, Docker, Docker Compose)...${RESET}"
apt install -y wget git curl docker.io docker-compose

# 启动 Docker 并设置开机自启
systemctl enable docker
systemctl start docker

# 克隆 NapthaAI 节点仓库
echo -e "${GREEN}📥 下载 NapthaAI 节点代码...${RESET}"
git clone https://github.com/NapthaAI/node.git ~/naptha-node
cd ~/naptha-node

# 复制默认环境变量文件
echo -e "${GREEN}⚙️ 配置环境变量 (.env)...${RESET}"
cp .env.example .env

# 提示用户输入 Docker Hub 账户信息
echo -n "请输入您的 Docker Hub 用户名: "
read HUB_USERNAME
echo -n "请输入您的 Docker Hub 密码: "
read -s HUB_PASSWORD
echo ""

# 更新 .env 文件
sed -i "s/HUB_USERNAME=/HUB_USERNAME=${HUB_USERNAME}/" .env
sed -i "s/HUB_PASSWORD=/HUB_PASSWORD=${HUB_PASSWORD}/" .env

# 提示用户输入 OpenAI API Key（可选）
echo -n "请输入您的 OpenAI API Key (如果有): "
read OPENAI_API_KEY
if [ -n "$OPENAI_API_KEY" ]; then
    sed -i "s/OPENAI_API_KEY=/OPENAI_API_KEY=${OPENAI_API_KEY}/" .env
fi

# 运行 NapthaAI 节点
echo -e "${GREEN}🚀 启动 NapthaAI 节点...${RESET}"
docker-compose up -d --force-recreate

echo -e "${GREEN}✅ 安装完成！您可以访问 NapthaAI 节点: http://localhost:7001 ${RESET}"
