FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --no-audit
COPY . .
RUN npx vite build
CMD ["sh", "-c", "node server.js --port ${PORT:-8000} --skipBuild"]
