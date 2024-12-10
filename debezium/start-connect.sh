#!/bin/bash

# 確保腳本有執行權限，使用 chmod +x start-connect.sh

echo "Starting Kafka Connect in the background..."
/docker-entrypoint.sh start &  # 將主進程放到背景


# 等待 Kafka Connect 完全啟動
echo "Waiting for Kafka Connect to fully start..."
sleep 60

# 發送初始化的 API 請求
echo "Running custom initialization commands..."
curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d @/kafka/connect/mongodb-connector.json

# 保持容器運行
wait  # 等待所有背景進程完成
