FROM node:18-alpine AS builder

WORKDIR /app
COPY index.html ./
RUN tar -zcvf site-assets.tar.gz index.html

FROM nginx:alpine

# 커스텀 설정 파일 적용
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/site-assets.tar.gz /tmp/

WORKDIR /usr/share/nginx/html

RUN tar -zxvf /tmp/site-assets.tar.gz && \
    rm /tmp/site-assets.tar.gz

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
