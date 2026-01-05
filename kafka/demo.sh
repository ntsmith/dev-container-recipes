#!/bin/bash
# Kafka Demo Script
# Run these commands from the workspace container

KAFKA_BROKER="kafka:9092"

echo "=== Kafka Demo ==="
echo

# Create a topic
echo "1. Creating topic 'demo-topic'..."
kafka-topics.sh --create --topic demo-topic --bootstrap-server $KAFKA_BROKER --partitions 1 --replication-factor 1 2>/dev/null || echo "   Topic may already exist"

# List topics
echo
echo "2. Listing topics..."
kafka-topics.sh --list --bootstrap-server $KAFKA_BROKER

# Describe topic
echo
echo "3. Describing 'demo-topic'..."
kafka-topics.sh --describe --topic demo-topic --bootstrap-server $KAFKA_BROKER

# Produce messages
echo
echo "4. Producing messages..."
echo -e "Hello Kafka\nThis is a test message\nMessage number 3" | kafka-console-producer.sh --topic demo-topic --bootstrap-server $KAFKA_BROKER

# Consume messages
echo
echo "5. Consuming messages (will show all messages then exit)..."
kafka-console-consumer.sh --topic demo-topic --bootstrap-server $KAFKA_BROKER --from-beginning --timeout-ms 3000 2>/dev/null

echo
echo "=== Demo Complete ==="
echo
echo "Useful commands:"
echo "  kafka-topics.sh --list --bootstrap-server $KAFKA_BROKER"
echo "  kafka-console-producer.sh --topic demo-topic --bootstrap-server $KAFKA_BROKER"
echo "  kafka-console-consumer.sh --topic demo-topic --bootstrap-server $KAFKA_BROKER --from-beginning"
