# Kafka Dev Container

Apache Kafka message broker with Zookeeper, running in a VSCode Dev Container.

## What's Included

- **Apache Kafka** - Distributed streaming platform
- **Zookeeper** - Coordination service for Kafka
- **Docker-in-Docker** - Run containers inside the dev container

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Start the Kafka stack:
   ```bash
   docker-compose -f .devcontainer/docker-compose.yml up -d
   ```
4. Run the POC test:
   ```bash
   ./poc-test.sh
   ```

## Demo

The `poc-test.sh` script demonstrates:
- Starting Zookeeper and Kafka
- Creating a test topic
- Producing messages
- Consuming messages

## Ports

| Port | Service |
|------|---------|
| 2181 | Zookeeper |
| 9092 | Kafka |

## Architecture

```
┌─────────────────┐     ┌─────────────────┐
│    Zookeeper    │◄────│      Kafka      │
│    (port 2181)  │     │   (port 9092)   │
└─────────────────┘     └─────────────────┘
```

## Files

```
kafka/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── setup.sh
├── poc-test.sh           # Demo script
└── README.md
```

## Notes

- Uses `--network=host` for easier localhost access
- Bitnami Zookeeper image for simplicity
- Kafka configured for single-node development
