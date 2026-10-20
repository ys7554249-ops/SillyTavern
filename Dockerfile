FROM node:22-alpine
WORKDIR /app
COPY . .
RUN npm ci --no-audit
RUN timeout 300 node server.js --port 8000 || true
RUN echo 'listen: true' > config.yaml && \
    echo 'whitelistMode: false' >> config.yaml && \
    echo 'basicAuthMode: true' >> config.yaml && \
    echo 'basicAuthUser:' >> config.yaml && \
    echo '  username: "nightstar"' >> config.yaml && \
    echo '  password: "sy199713"' >> config.yaml && \
    echo 'disableCsrfProtection: true' >> config.yaml && \
    echo 'securityOverride: true' >> config.yaml
CMD ["sh", "-c", "node server.js --port ${PORT:-8000} --skipBuild"]
