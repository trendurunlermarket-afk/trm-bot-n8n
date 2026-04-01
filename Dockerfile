FROM n8nio/n8n:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    ca-certificates \
    fonts-liberation \
    libcairo2 \
    libasound2 \
    libatspi2.0-0 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    libxrender1 \
    libxshmfence1 \
    libxss1 \
    libxtst6 \
    xdg-utils \
 && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    if [ -x /usr/bin/chromium ]; then exit 0; fi; \
    if command -v chromium >/dev/null 2>&1; then ln -sf "$(command -v chromium)" /usr/bin/chromium; exit 0; fi; \
    if command -v chromium-browser >/dev/null 2>&1; then ln -sf "$(command -v chromium-browser)" /usr/bin/chromium; exit 0; fi; \
    ls -la /usr/bin | head -n 200; \
    exit 1

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV NODE_PATH=/usr/local/lib/node_modules

RUN npm install -g puppeteer

USER node
