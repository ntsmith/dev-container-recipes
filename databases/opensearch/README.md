# OpenSearch Dev Container

A development container for OpenSearch, the open-source search and analytics suite.

## Services

- **workspace**: Development environment with curl and jq
- **opensearch**: OpenSearch 2.12.0 running in single-node mode

## Ports

- `9200`: REST API
- `9600`: Performance Analyzer

## Quick Start

Once the container is running:

```bash
# Check cluster health
curl http://opensearch:9200/_cluster/health | jq

# Check cluster info
curl http://opensearch:9200 | jq
```

Or use the `demo.http` file with the REST Client extension.

## API Examples

```bash
# Create an index
curl -X PUT "http://opensearch:9200/my-index" \
  -H "Content-Type: application/json" \
  -d '{"settings": {"number_of_shards": 1}}'

# Index a document
curl -X POST "http://opensearch:9200/my-index/_doc" \
  -H "Content-Type: application/json" \
  -d '{"title": "Hello", "content": "World"}'

# Search
curl "http://opensearch:9200/my-index/_search" | jq

# List indices
curl "http://opensearch:9200/_cat/indices?v"
```

## Configuration Notes

- Security plugin is disabled for demo purposes
- Memory limited to 512MB (`-Xms512m -Xmx512m`)
- Data persisted in Docker volume

## OpenSearch vs Elasticsearch

OpenSearch is a community-driven fork of Elasticsearch 7.10.2. The API is largely compatible, making it easy to migrate between the two.
