FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# --from=builder will fail in AWS use unnamed from statement (eg --from=0)
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

