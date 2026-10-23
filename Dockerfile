FROM alpine:latest
RUN apk add --no-cache curl unzip tzdata && \
    mkdir -p /usr/local/xray && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/xray && \
    chmod +x /usr/local/xray/xray && rm /tmp/xray.zip
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["sh", "/start.sh"]
