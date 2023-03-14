FROM node:18.15.0-alpine3.16 as my-app

WORKDIR /app

COPY package.json /app

RUN npm install 

COPY . .

RUN npm run build

FROM nginx:alpine

VOLUME /var/cache/nginx

COPY --from=my-app app/dist/my-app usr/share/nginx/html

COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf