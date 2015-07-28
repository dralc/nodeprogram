
var util = require('util')
    , mongodb = require('mongodb')
    , MongoClient = mongodb.MongoClient
    , assert = require('assert')
    , http = require('http')
    ;

console.log('******* --------env start --------- *********');
util.inspect(process.env);
console.log('******* ------- env  end ---------- *********');

var dbConnUrl = process.env.MONGOLAB_URI || 'mongodb://localhost:27017/test';

MongoClient.connect(dbConnUrl, function (err, db) {

    assert.equal(null, err);

    var server = http.createServer(function (req, res) {

        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Mongo connected1');
    });

    server.listen(process.env.PORT || 1337, function () {
        console.log('Server running at %s:%s', server.address().address, server.address().port);
    });

    db.close();

    //var collection = db.collection('aloy');
    //collection.find().toArray(function (er, coll) {
    //    console.log(arguments);
    //
    //    db.close();
    //});
});
