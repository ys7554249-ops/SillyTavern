FROM node:22-alpine
WORKDIR /app
COPY . .
RUN npm ci --no-audit
RUN timeout 300 node server.js --port 8000 || true
CMD ["sh", "-c", "sed -i 's/listen: false/listen: true/' config.yaml && sed -i 's/whitelistMode: true/whitelistMode: false/' config.yaml && sed -i 's/basicAuthMode: false/basicAuthMode: true/' config.yaml && sed -i 's/username: \"\"/username: \"nightstar\"/' config.yaml && sed -i 's/password: \"\"/password: \"sy199713\"/' config.yaml && node server.js --port ${PORT:-8000} --skipBuild"]
