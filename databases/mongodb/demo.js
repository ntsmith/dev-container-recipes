// MongoDB Demo
// Run with: mongosh mongodb://mongodb:27017 demo.js
// Or interactively: mongosh mongodb://mongodb:27017

// Switch to demo database
db = db.getSiblingDB('mydatabase');

// Insert a document
db.mycollection.insertOne({ name: 'Alice', age: 30 });
print('Inserted Alice');

// Query the document
print('Finding Alice:');
printjson(db.mycollection.findOne({ name: 'Alice' }));

// Insert multiple documents
db.mycollection.insertMany([
    { name: 'Bob', age: 25 },
    { name: 'Charlie', age: 35 }
]);
print('Inserted Bob and Charlie');

// Query all documents
print('All documents:');
db.mycollection.find().forEach(printjson);

// Query with filter
print('People older than 25:');
db.mycollection.find({ age: { $gt: 25 } }).forEach(printjson);
