# Dev Container Demos - Databases

This repository contains examples of **VSCode Dev Containers** for working with different databases.
Each subdirectory corresponds to a specific database and provides a  **Jupyter Notebook** to demonstrate basic usage.

## Databases Supported

- **DuckDB** – An embedded database with SQL support.
- **Redis** – An in-memory key-value store, often used as a cache or message broker.
- **MariaDB** – A popular SQL database, originally based on MySQL.
- **MongoDB** – A popular NoSQL database for storing JSON-like documents.
  
More databases may be added in the future.

## Database Demos

How to test:
   - Open each folder in VSCode
   - Reopen the folder in a container when prompted.
   - Run the include Jupyter notebook to explore the basic functionality

### DuckDB

DuckDB is a high-performance, embedded database with SQL support, ideal for analytics.
This container includes DuckDB and a Jupyter Notebook that demonstrates how to load a CSV file and make a SQL query

### Redis

Redis is an in-memory key-value store. This Dev Container sets up a Redis server and a Jupyter notebook that makes a connection, sets data, and retrieves data.

### MongoDB

MongoDB is a NoSQL database designed for storing and retrieving document-oriented data. This container sets up a mongodb server.
The Jupyter notebook demonstrates how to connect, insert data, and query the database

.