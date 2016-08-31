# Nodejs HTTP client
Simple http client to handle requests at http://localhost:8080
```javascript
http.createServer(handler)
    .listen(8080)

function handler(req, res) {
    req.url;  // This route can be handled now
    res.end('Hello');
}
```
\> [More details][nodecasts-httpclient]

# ExpressJS
* Simple express http client to handle 2 routes at http://localhost:8080

```javascript
var express = require('express');
var app = express();

// Set and handle ROUTES
app.get('/', function (req, res) {
    res.send('Home');   // sends text
    // OR
    res.sendFile(`${__dirname}/index.html`);   // sends a file
});

app.get('/tours', function (req, res) {
    res.send('Tours');
});

var server = app.listen(8080, function () {
    console.log(`The app is running at ${server.address().address}`);
});
```

* Serving static files
```javascript
var express = require('express');

// Looks for all static files in __dirname/www
app.use(express.static('www');

```


\> [More details][nodecasts-express]




[#]: -------------------------------------------------------------------
(These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[nodecasts-httpclient]: <https://courses.nodecasts.io/courses/introduction-to-node-js/lectures/1119972>
[nodecasts-express]: <https://courses.nodecasts.io/courses/express-js>

