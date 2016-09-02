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

# Express.js
## Intro
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
// Looks for all static files in __dirname/www
app.use(express.static('www');
```

* Templating
```javascript
// Looks for jade files in __dirname/views
app.set('view engine', 'jade');

app.get('/', function () {
    res.render('index', dataObj);
});
```

\> [More details][nodecasts-express]

## App wide 'config' variables
* Usage
```javascript
app.set('myAppVar', myVal)
app.get('myAppVar') // OR p= myAppVar in jade

app.enable('myAppBoolean') // alt to app.set(myAppBoolean, true)
app.disable('myAppBoolean')

if (app.enabled('myAppBoolean')) // tests if config is true
if (app.disabled('myAppBoolean'))
```

### 'env'
Defaults to 'development'
```javascript
app.set('env', 'production') // OR
process.env.NODE_ENV=production

// Better to set it when build/run script
$ NODE_ENV=production node app // OR
exports NODE_ENV=production


// Group environment configs together
app.configure('development', function(){
    app.set('capiUrl', 'http://testUrl');
});

app.configure('staging', 'production', function () {
    app.set('capiUrl', process.env.app_capi_url);
});
```

### 'view cache'
Sets whether to cache compiled templates.
`false` is default, `true` when `env` is 'production'

### 'view engine'
Sets the template file extension

### 'views'
Sets the folder location of templates.
Defaults to `__dirname/views`
```javascript
app.set('views', '${__dirname}/templates')
```

### 'trust proxy'
??

### 'json replacer' & 'json spaces'
Sets the behaviour for `res.json()`

### 'case sensitive routing' & 'strict routing'
Sets whether case and trailing '/' in the route is important
Defaults to `false`

### 'x-powered-by'
Sets the HTTP response header `X-Powered-By=Express`
Defaults to `true`

### 'etag'
Sets HTTP caching mechanism
Defaults to `true`

### 'subdomain offset'
Sets the return behaviour of `req.subdomains`

## Middleware
You set up middleware to handle tasks prior to serving the http response.

```javascript
app.use('/myroute', function (req, res, next) {
  console.log(req.url);
  return next();
});

app.get('/myroute', function (req, res) {
  res.send('hello');
});
```







[#]: -------------------------------------------------------------------
(These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[nodecasts-httpclient]: <https://courses.nodecasts.io/courses/introduction-to-node-js/lectures/1119972>
[nodecasts-express]: <https://courses.nodecasts.io/courses/express-js>

