# need to use the specific version of node that is dist is built 
FROM node:18.14.0. AS builder

WORKDIR /week4-worksheet

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

COPY --from=builder /week4-worksheet/dist/week4-worksheet /html

COPY ../nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'