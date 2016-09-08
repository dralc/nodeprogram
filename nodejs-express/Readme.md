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

    // Internally calls app.engine('jade', require('jade').__express) where the 2nd fn param needs to implement a certain interface

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
Are the handlers of a Request.

Called via `app.use('myRoute', middlewareObj)`

### Types
> Third party middleware in v3 will need to be manually require()'d in v4. [Details here][changes3to4]

* gzipping (compression)
* logging requests (morgan)
* request body parsing as JSON, form-url-encoded, raw, text (body-parser), form-multipart (multer)
* cookie parsing (cookie-parser)
* session handling (express-session)
* 'cross site request forgery' protection (csurf)
* serve static files, dir (serve-static, serve-index)
* virtual host handling (vhost)
* basic authentication (? ...express.basicAuth())
* ...

# Handling named URL params
## app.param
Sets callbacks for matching named/[route parameters](http://expressjs.com/en/guide/routing.html#route-parameters)

```javascript
app.param('userId', function (req) {
    // Sets the user
    req.user = getUserFromId();
})

app.get('/my/route/:userId', function () {
    // Consume req.user
})

app.get('/other/:userId/route', function () {
    // Consume req.user
})
```
# Routing
## app.METHOD()
Routing calls are based on RESTful names. ie. get, post,.. [All supported methods](http://expressjs.com/en/4x/api.html#routing-methods)

```javascript
app.get('/my/route/or/regex', function (req, res, next) {
    next([anError]) // to move on to the next middleware
    next('route') // to move on to the next matching route
    res.end() // to end without data response
    res.status(404).end(); // end with error status

    // End WITH data response
    res.send()
    res.sendFile()
    res.json()
});

// Use multiple middleware
app.get('/my/path/admin', authAdmin, getUsers, renderUsers);

// OR use a dynamic queue of middleware
var adminQueue = [authAdmin, getUsers, renderUsers];
app.get('/my/path/admin', adminQueue);
```

## app.all()
Handle any request without specifying RESTful METHOD
```javascript
app.all('*', userAuth);
```



[#]: -------------------------------------------------------------------
(These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[nodecasts-httpclient]: <https://courses.nodecasts.io/courses/introduction-to-node-js/lectures/1119972>
[nodecasts-express]: <https://courses.nodecasts.io/courses/express-js>
[changes3to4]: <http://expressjs.com/en/guide/migrating-4.html#changes>
