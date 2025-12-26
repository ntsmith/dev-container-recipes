#!/bin/bash
set -e

# Install dependencies
apt-get update && apt-get install -y \
  openjdk-11-jdk \
  wget \
  netcat \
  unzip \
  tar \
  curl

# Define Kafka version
KAFKA_VERSION="3.6.0"
SCALA_VERSION="2.13"
KAFKA_DIR="/opt/kafka"

# Download and extract Kafka if not already installed
if [ ! -d "$KAFKA_DIR" ]; then
  wget -qO- "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" | tar -xz -C /opt
  mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} $KAFKA_DIR
fi

# Add Kafka to PATH
echo "export PATH=\$PATH:${KAFKA_DIR}/bin" >> /root/.bashrc
echo "export KAFKA_HOME=${KAFKA_DIR}" >> /root/.bashrc
source /root/.bashrc

# Create Kafka data directories
mkdir -p /data/kafka /data/zookeeper

# Configure Zookeeper
cat <<EOF > ${KAFKA_DIR}/config/zookeeper.properties
tickTime=2000
dataDir=/data/zookeeper
clientPort=2181
maxClientCnxns=60
EOF

# Configure Kafka
cat <<EOF > ${KAFKA_DIR}/config/server.properties
broker.id=1
log.dirs=/data/kafka
zookeeper.connect=localhost:2181
listeners=PLAINTEXT://0.0.0.0:9092
advertised.listeners=PLAINTEXT://localhost:9092
num.network.threads=3
num.io.threads=8
log.retention.hours=168
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
zookeeper.connection.timeout.ms=6000
EOF

# Start Zookeeper in the background
echo "Starting Zookeeper..."
nohup ${KAFKA_DIR}/bin/zookeeper-server-start.sh ${KAFKA_DIR}/config/zookeeper.properties > /var/log/zookeeper.log 2>&1 &

# Wait for Zookeeper to be ready
echo "Waiting for Zookeeper to start..."
while ! nc -z localhost 2181; do   
  sleep 1
done

# Start Kafka in the background
echo "Starting Kafka..."
nohup ${KAFKA_DIR}/bin/kafka-server-start.sh ${KAFKA_DIR}/config/server.properties > /var/log/kafka.log 2>&1 &

# Verify Kafka is running
sleep 5
echo "Kafka topics available:"
${KAFKA_DIR}/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list