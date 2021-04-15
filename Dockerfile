FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# --from=builder will fail in AWS use unnamed from statement (eg --from=0)
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html

