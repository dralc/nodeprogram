var util = require('util');
var mongodb = require('mongodb');

//
//var Db = mongodb.Db;
//var Connection = mongodb.Connection;
//var Server = mongodb.Server;
//var host = '127.0.0.1';
//var port = 27017;
//
//
//var db = new Db('test', new Server(host, port, {}));
//
//db.open(function(e,c) {
//    //console.log(util.inspect(db));
//    console.log(db._state);
//    db.close();
//});
//

var MongoClient = mongodb.MongoClient
    , assert = require('assert');

var url = 'mongodb://localhost:27017/test';

MongoClient.connect(url, function(err, db) {
    assert.equal(null, err);

    var collection = db.collection('aloy');
    collection.find().toArray(function (er, coll) {
        console.log(arguments);
    });

});

