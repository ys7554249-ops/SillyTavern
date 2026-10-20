FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --no-audit
COPY . .
RUN npx vite build
RUN mkdir -p config && cp -n default/config.yaml config/config.yaml && \
    sed -i 's/listen: false/listen: true/' config/config.yaml && \
    sed -i 's/whitelistMode: true/whitelistMode: false/' config/config.yaml && \
    sed -i 's/basicAuthMode: false/basicAuthMode: true/' config/config.yaml && \
    sed -i 's/username: ""/username: "nightstar"/' config/config.yaml && \
    sed -i 's/password: ""/password: "sy199713"/' config/config.yaml
CMD ["sh", "-c", "node server.js --port ${PORT:-8000} --skipBuild"]
