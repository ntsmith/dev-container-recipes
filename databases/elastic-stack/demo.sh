#!/bin/bash
# Elastic Stack Demo Script

ES_HOST="http://elasticsearch:9200"
LOGSTASH_HOST="logstash"
LOGSTASH_PORT="5044"

echo "=== Elastic Stack Demo ==="
echo

# Wait for Elasticsearch
echo "1. Waiting for Elasticsearch..."
until curl -s "$ES_HOST" > /dev/null 2>&1; do
    sleep 2
done
echo "   Elasticsearch is ready!"

# Check cluster health
echo
echo "2. Cluster health:"
curl -s "$ES_HOST/_cluster/health" | jq '.status, .number_of_nodes'

# Create sample index
echo
echo "3. Creating 'demo-logs' index..."
curl -s -X PUT "$ES_HOST/demo-logs" -H "Content-Type: application/json" -d '{
    "settings": { "number_of_shards": 1, "number_of_replicas": 0 },
    "mappings": {
        "properties": {
            "timestamp": { "type": "date" },
            "level": { "type": "keyword" },
            "message": { "type": "text" }
        }
    }
}' | jq '.acknowledged'

# Index sample documents
echo
echo "4. Indexing sample log entries..."
for i in {1..5}; do
    level=$(echo "INFO WARN ERROR DEBUG" | tr ' ' '\n' | shuf -n 1)
    curl -s -X POST "$ES_HOST/demo-logs/_doc" -H "Content-Type: application/json" -d "{
        \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",
        \"level\": \"$level\",
        \"message\": \"Sample log message number $i\"
    }" > /dev/null
    echo "   Indexed document $i ($level)"
done

# Refresh index
curl -s -X POST "$ES_HOST/demo-logs/_refresh" > /dev/null

# Search
echo
echo "5. Searching for all documents:"
curl -s "$ES_HOST/demo-logs/_search?pretty" | jq '.hits.total.value, .hits.hits[]._source'

# Send data to Logstash
echo
echo "6. Sending data to Logstash..."
if nc -z $LOGSTASH_HOST $LOGSTASH_PORT 2>/dev/null; then
    echo '{"event": "demo", "message": "Hello from demo script", "level": "INFO"}' | nc -w 1 $LOGSTASH_HOST $LOGSTASH_PORT
    echo "   Data sent to Logstash (check logstash-* index in a few seconds)"
else
    echo "   Logstash not ready yet, skipping..."
fi

echo
echo "=== Demo Complete ==="
echo
echo "Access points:"
echo "  Elasticsearch: $ES_HOST"
echo "  Kibana:        http://localhost:5601"
echo "  Logstash:      $LOGSTASH_HOST:$LOGSTASH_PORT (TCP/JSON)"
echo
echo "Try opening Kibana at http://localhost:5601 to visualize the data!"
