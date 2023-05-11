FROM node:14

# 安装必要的依赖
RUN apt-get update && apt-get install -y wget xvfb libxi6 libgconf-2-4

# 安装Chrome浏览器
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y google-chrome-stable

# 设置环境变量
ENV DISPLAY=:99

# 安装项目依赖
WORKDIR /app
COPY package*.json ./
RUN npm install

# 复制项目文件
COPY . .

# 启动Xvfb和Chrome浏览器
CMD Xvfb :99 -screen 0 1280x720x16 \
    && google-chrome-stable --no-sandbox --disable-gpu --remote-debugging-port=9222 \
    && npm run dev
