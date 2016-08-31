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
Simple express http client to handle 2 routes at http://localhost:8080

```javascript
var app = express();

// Set and handle ROUTES
app.get('/', function (req, res) {
    res.send('<h1>Home</h1>');
});

app.get('/tours', function (req, res) {
    res.send('<h1>Tours</h1>');
});

var server = app.listen(8080, function () {
    console.log(`The app is running at ${server.address().address}`);
});
```

\> [More details][nodecasts-express]




[#]: -------------------------------------------------------------------
(These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[nodecasts-httpclient]: <https://courses.nodecasts.io/courses/introduction-to-node-js/lectures/1119972>
[nodecasts-express]: <https://courses.nodecasts.io/courses/express-js>

