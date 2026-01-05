#!/bin/bash
# Redis Demo
# Run with: ./demo.sh
# Or interactively: redis-cli -h redis

REDIS_HOST="redis"

echo "=== Redis Demo ==="
echo

echo "# Ping the server"
redis-cli -h $REDIS_HOST PING
echo

echo "# Set a simple key-value"
redis-cli -h $REDIS_HOST SET name "Alice"
echo

echo "# Get the value"
redis-cli -h $REDIS_HOST GET name
echo

echo "# Store JSON as a string"
redis-cli -h $REDIS_HOST SET "person:1" '{"name": "Bob", "age": 30}'
echo

echo "# Retrieve the JSON"
redis-cli -h $REDIS_HOST GET "person:1"
echo

echo "# Set multiple keys"
redis-cli -h $REDIS_HOST MSET "person:2" '{"name": "Charlie", "age": 35}' "person:3" '{"name": "Diana", "age": 28}'
echo

echo "# Get all person keys"
redis-cli -h $REDIS_HOST KEYS "person:*"
echo

echo "# Use a hash for structured data"
redis-cli -h $REDIS_HOST HSET user:1 name "Eve" age 25 city "NYC"
redis-cli -h $REDIS_HOST HGETALL user:1
