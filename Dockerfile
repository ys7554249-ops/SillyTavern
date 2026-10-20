FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --no-audit
COPY . .
RUN npx vite build || true

FROM node:22-alpine
WORKDIR /app
COPY --from=build /app /app
EXPOSE 8000
CMD ["node", "server.js", "--port", "8000", "--skipBuild"]
