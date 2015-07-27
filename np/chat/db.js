var util = require('util')
    , mongodb = require('mongodb')
    , MongoClient = mongodb.MongoClient
    , assert = require('assert')
    ;

var dbConnUrl = process.env.MONGOHQ_URL || 'mongodb://localhost:27017/test';

MongoClient.connect(dbConnUrl, function (err, db) {
    assert.equal(null, err);

    var collection = db.collection('aloy');
    collection.find().toArray(function (er, coll) {
        console.log(arguments);

        db.close();
    });
});
