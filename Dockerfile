FROM node:22-alpine
WORKDIR /app
COPY . .
RUN npm ci --no-audit
RUN timeout 300 node server.js --port 8000 || true
RUN node -e "const y=require('js-yaml'),fs=require('fs');const c=y.load(fs.readFileSync('config.yaml','utf8'));c.listen=true;c.whitelistMode=false;c.basicAuthMode=true;if(!c.basicAuthUser)c.basicAuthUser={};c.basicAuthUser.username='nightstar';c.basicAuthUser.password='sy199713';fs.writeFileSync('config.yaml',y.dump(c));"
CMD ["sh", "-c", "node server.js --port ${PORT:-8000} --skipBuild"]
