FROM node:lts-alpine as builder

WORKDIR /app

COPY package.json .
COPY pnpm-lock.yaml .

RUN rm -rf node_modules
RUN npm install -g pnpm
RUN pnpm install

COPY . .

RUN pnpm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html