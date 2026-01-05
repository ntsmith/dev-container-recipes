#!/bin/bash
# OpenSearch Stack Demo Script

OS_HOST="http://opensearch:9200"
DP_HOST="http://data-prepper:2021"

echo "=== OpenSearch Stack Demo ==="
echo

# Wait for OpenSearch
echo "1. Waiting for OpenSearch..."
until curl -s "$OS_HOST" > /dev/null 2>&1; do
    sleep 2
done
echo "   OpenSearch is ready!"

# Check cluster health
echo
echo "2. Cluster health:"
curl -s "$OS_HOST/_cluster/health" | jq '{status, number_of_nodes}'

# Create sample index
echo
echo "3. Creating 'demo-logs' index..."
curl -s -X PUT "$OS_HOST/demo-logs" -H "Content-Type: application/json" -d '{
    "settings": { "number_of_shards": 1, "number_of_replicas": 0 },
    "mappings": {
        "properties": {
            "@timestamp": { "type": "date" },
            "level": { "type": "keyword" },
            "service": { "type": "keyword" },
            "message": { "type": "text" }
        }
    }
}' | jq '.acknowledged'

# Index sample documents directly to OpenSearch
echo
echo "4. Indexing sample documents to OpenSearch..."
for i in {1..3}; do
    level=$(echo "INFO WARN ERROR" | tr ' ' '\n' | shuf -n 1)
    curl -s -X POST "$OS_HOST/demo-logs/_doc" -H "Content-Type: application/json" -d "{
        \"@timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",
        \"level\": \"$level\",
        \"service\": \"demo-service\",
        \"message\": \"Direct log message $i\"
    }" > /dev/null
    echo "   Indexed document $i ($level)"
done

# Send data via Data Prepper
echo
echo "5. Sending data via Data Prepper..."
if curl -s "$DP_HOST/log/ingest" -X POST -H "Content-Type: application/json" -d '[
    {"level": "INFO", "service": "api", "message": "Via Data Prepper 1"},
    {"level": "WARN", "service": "worker", "message": "Via Data Prepper 2"},
    {"level": "ERROR", "service": "scheduler", "message": "Via Data Prepper 3"}
]' > /dev/null 2>&1; then
    echo "   Data sent to Data Prepper (check logs-* index)"
else
    echo "   Data Prepper not ready yet, skipping..."
fi

# Refresh and search
echo
echo "6. Searching demo-logs:"
curl -s -X POST "$OS_HOST/demo-logs/_refresh" > /dev/null
curl -s "$OS_HOST/demo-logs/_search" | jq '.hits.total.value as $total | .hits.hits[]._source | {level, message} | "\(.level): \(.message)"'

echo
echo "=== Demo Complete ==="
echo
echo "Access points:"
echo "  OpenSearch:    $OS_HOST"
echo "  Dashboards:    http://localhost:5601"
echo "  Data Prepper:  $DP_HOST/log/ingest (POST)"
echo
echo "Try opening OpenSearch Dashboards at http://localhost:5601"
