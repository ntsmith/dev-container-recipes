# OpenSearch Stack Dev Container

A complete OpenSearch Stack development environment with OpenSearch, OpenSearch Dashboards, and Data Prepper.

## Services

| Service | Port | Description |
|---------|------|-------------|
| OpenSearch | 9200 | Search and analytics engine |
| OpenSearch Dashboards | 5601 | Visualization and management UI |
| Data Prepper | 2021 | Data ingestion pipeline (HTTP) |
| Data Prepper | 4900 | Metrics endpoint |

## Quick Start

1. Open this folder in VS Code and reopen in container
2. Wait for all services to start (may take 1-2 minutes)
3. Run the demo script:
   ```bash
   ./demo.sh
   ```
4. Open OpenSearch Dashboards at http://localhost:5601

## Using OpenSearch Dashboards

1. Navigate to http://localhost:5601
2. Go to **Management** → **Dashboards Management** → **Index Patterns**
3. Create index patterns for `demo-logs*`, `logs-*`, and `metrics-*`
4. Go to **Discover** to explore your data

## Sending Data to Data Prepper

Data Prepper accepts JSON via HTTP:

```bash
# Send logs
curl -X POST "http://data-prepper:2021/log/ingest" \
  -H "Content-Type: application/json" \
  -d '[{"level": "INFO", "message": "Hello World"}]'

# Send metrics
curl -X POST "http://data-prepper:2021/metrics/ingest" \
  -H "Content-Type: application/json" \
  -d '[{"name": "cpu_usage", "value": 45.2}]'
```

## OpenSearch API Examples

```bash
# Cluster health
curl http://opensearch:9200/_cluster/health | jq

# List indices
curl http://opensearch:9200/_cat/indices?v

# Search logs
curl http://opensearch:9200/logs-*/_search | jq

# Index a document directly
curl -X POST http://opensearch:9200/my-index/_doc \
  -H "Content-Type: application/json" \
  -d '{"message": "Test"}'
```

## Data Prepper Pipelines

Two pipelines are configured:

1. **log-pipeline**: Receives logs at `/log/ingest` → indexes to `logs-YYYY.MM.dd`
2. **metrics-pipeline**: Receives metrics at `/metrics/ingest` → indexes to `metrics-YYYY.MM.dd`

## Files

```
opensearch-stack/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── pipelines.yaml          # Data Prepper pipelines
│   └── data-prepper-config.yaml
├── demo.http                   # REST Client examples
├── demo.sh                     # Demo script
└── README.md
```

## Configuration Notes

- Security is disabled for demo purposes
- OpenSearch memory: 512MB (`-Xms512m -Xmx512m`)
- All data persisted in Docker volumes

## OpenSearch vs Elasticsearch

OpenSearch is a community-driven fork of Elasticsearch. The API is largely compatible, and Data Prepper serves a similar role to Logstash.
