#!/bin/bash

KAFKA_DIR="/opt/kafka"
ZOOKEEPER_CONFIG="${KAFKA_DIR}/config/zookeeper.properties"
KAFKA_CONFIG="${KAFKA_DIR}/config/server.properties"

echo "Starting POC tests for Kafka..."

# Function to check if a process is running
is_running() {
    pgrep -f "$1" > /dev/null
}

# Start Zookeeper if not running
if ! is_running "zookeeper"; then
    echo "Starting Zookeeper..."
    nohup zookeeper-server-start.sh "$ZOOKEEPER_CONFIG" > /dev/null 2>&1 &
    sleep 5
else
    echo "Zookeeper is already running."
fi

# Start Kafka if not running
if ! is_running "kafka.Kafka"; then
    echo "Starting Kafka..."
    nohup kafka-server-start.sh "$KAFKA_CONFIG" > /dev/null 2>&1 &
    sleep 10
else
    echo "Kafka is already running."
fi

# Ensure Kafka is running before proceeding
if ! is_running "kafka.Kafka"; then
    echo "Error: Kafka failed to start. Exiting..."
    exit 1
fi

# Create a test topic
echo "Creating test topic: poc-topic"
kafka-topics.sh --create --topic poc-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1 || echo "Topic may already exist."

# List topics
echo "Listing available topics:"
kafka-topics.sh --list --bootstrap-server localhost:9092

# Produce test messages
echo "Sending test messages to poc-topic..."
echo -e "Hello\nKafka\nPOC" | kafka-console-producer.sh --topic poc-topic --bootstrap-server localhost:9092 > /dev/null

# Consume messages
echo "Consuming messages from poc-topic:"
kafka-console-consumer.sh --topic poc-topic --from-beginning --bootstrap-server localhost:9092 --timeout-ms 5000

echo "Kafka POC tests completed!"
