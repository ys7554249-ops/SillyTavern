FROM node:22-alpine
WORKDIR /app
COPY . .
RUN npm ci --no-audit
RUN timeout 300 node server.js --port 8000 || true
CMD ["sh", "-c", "node server.js --port ${PORT:-8000} --skipBuild --listen --disableWhitelist --basicAuthMode --basicAuthUser nightstar --basicAuthPass sy199713"]
