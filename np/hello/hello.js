var http = require('http');
var port = process.env.PORT || 1337;
var server = http.createServer(function (request, response) {
    response.setHeader('Content-Type', 'text/plain');
    response.end('Hello world');
});

server.listen(port);