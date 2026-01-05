# Elastic Stack (ELK) Dev Container

A complete Elastic Stack development environment with Elasticsearch, Logstash, and Kibana.

## Services

| Service | Port | Description |
|---------|------|-------------|
| Elasticsearch | 9200 | Search and analytics engine |
| Kibana | 5601 | Visualization and management UI |
| Logstash | 5044 | Data processing pipeline (TCP/JSON input) |
| Logstash | 9600 | Monitoring API |

## Quick Start

1. Open this folder in VS Code and reopen in container
2. Wait for all services to start (may take 1-2 minutes)
3. Run the demo script:
   ```bash
   ./demo.sh
   ```
4. Open Kibana at http://localhost:5601

## Using Kibana

1. Navigate to http://localhost:5601
2. Go to **Management** → **Stack Management** → **Index Patterns**
3. Create index patterns for `demo-logs*` and `logstash-*`
4. Go to **Analytics** → **Discover** to explore your data

## Sending Data to Logstash

Send JSON data via TCP:

```bash
# Single event
echo '{"level": "INFO", "message": "Hello World"}' | nc logstash 5044

# Multiple events
cat <<EOF | nc logstash 5044
{"level": "INFO", "message": "First event"}
{"level": "ERROR", "message": "Something went wrong"}
{"level": "DEBUG", "message": "Debug information"}
EOF
```

## Elasticsearch API Examples

```bash
# Cluster health
curl http://elasticsearch:9200/_cluster/health | jq

# List indices
curl http://elasticsearch:9200/_cat/indices?v

# Search
curl http://elasticsearch:9200/demo-logs/_search | jq

# Index a document
curl -X POST http://elasticsearch:9200/demo-logs/_doc \
  -H "Content-Type: application/json" \
  -d '{"level": "INFO", "message": "Test"}'
```

## Files

```
elastic-stack/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── logstash.conf      # Logstash pipeline config
├── demo.http              # REST Client examples
├── demo.sh                # Demo script
└── README.md
```

## Configuration Notes

- Security is disabled for demo purposes (`xpack.security.enabled=false`)
- Elasticsearch memory: 512MB (`-Xms512m -Xmx512m`)
- Logstash memory: 256MB (`-Xms256m -Xmx256m`)
- All data persisted in Docker volumes
