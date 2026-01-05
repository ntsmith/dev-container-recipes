# Kafka Dev Container

A development container for Apache Kafka using KRaft mode (no Zookeeper required).

## Services

- **workspace**: Development environment with Kafka CLI tools
- **kafka**: Kafka broker running in KRaft mode (combined controller + broker)

## Ports

- `9092`: Kafka broker (PLAINTEXT)
- `9093`: Kafka controller

## Quick Start

Once the container is running, open a terminal and run:

```bash
# Run the demo script
./demo.sh
```

## Manual Commands

```bash
# List topics
kafka-topics.sh --list --bootstrap-server kafka:9092

# Create a topic
kafka-topics.sh --create --topic my-topic --bootstrap-server kafka:9092 --partitions 3 --replication-factor 1

# Produce messages (type messages, Ctrl+C to exit)
kafka-console-producer.sh --topic my-topic --bootstrap-server kafka:9092

# Consume messages
kafka-console-consumer.sh --topic my-topic --bootstrap-server kafka:9092 --from-beginning

# Describe a topic
kafka-topics.sh --describe --topic my-topic --bootstrap-server kafka:9092

# Delete a topic
kafka-topics.sh --delete --topic my-topic --bootstrap-server kafka:9092
```

## Files

```
kafka/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   └── Dockerfile
├── demo.sh              # Demo script
└── README.md
```
