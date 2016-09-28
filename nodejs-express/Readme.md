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

    // Internally calls app.engine('jade', require('jade').__express) where the
    // 2nd fn param needs to implement a certain interface

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
Are the handler/s of a *Route*. You can register them at:
* Application-level: `app.use()`, [details](http://expressjs.com/en/4x/api.html#app.use)
* Router-level; `router.use()`, [details ](http://expressjs.com/en/guide/using-middleware.html#middleware.router)

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
    return next([anError]) // to move on to the next route handler or middleware
    return next('route') // OR to move on to the next matching route
    res.end() // OR to end without data response
    res.status(404).end(); // OR end with error status

    // OR End WITH a data response
    res.send()
    res.sendFile()
    res.json()
});

// ----- Use multiple middleware -----
app.get('/my/path/admin', authAdmin, getUsers, renderUsers);
// !remember to call next() to trigger subsequent handlers

// ----- OR use a dynamic queue of middleware -----
var adminQueue = [authAdmin, getUsers, renderUsers];
app.get('/my/path/admin', adminQueue);
```

## app.all()
Handle any request without specifying the RESTful METHOD
```javascript
app.all('*', userAuth);
```

## Router instances (Express 4)
* Specifying routes and the handlers is less repetitive via chaining.
* Each _Router_ instance is set up like a mini express.js app. See example below.

```javascript
// ----- File: routers/section1.js -----
router = express.Router();
// router.all(fn);
router.route('/my/route')     // OR app.route()
      .all(fn1)
      .get(fn2)
      .post(fn3)
      ...
// router.param('/my/user/:id, fn);
module.exports = router;


// ------ File: Main.js ------
app = express();
section1Router = require('./routers/section1')
app.use('/section1', section1Router);
```

## Route path
Can be a:
* String `'/my/route'` (nb. `-` and `.` are interpreted literally)
* String pattern `'/my/(ro*te'`
* Regex `'/.*fly$/'`

# Request
Power-up for nodejs `http.request`

* `req.query`: The query string params in the request url
* `req.params`: A more direct way to list out any named URL parameters (/aroute/:my/:param) in route/s
* `req.body`: Provided by _body-parser_ middleware
* `req.files`: Provided by _multer_ middleware
* `req.route`: Gets route info
* `req.cookies`: Provided by _cookie-parser_ middleware
* `req.header/get('content-type')`: Gets a http header field
* `req.accepts`(type): Checks what content type the requesting client accepts. Used by [_res.format()_](http://expressjs.com/en/api.html#res.format)
* ...

# Response
Power-up for nodejs `http.response`

* `res.render`(templateName, [data], [cb(err, html)]): Parse template file and calls _res.send(html)_ by default if _cb_ wasn't provided
* `res.locals`: An alternative way to passing data the template
* `res.set(headersObj)`: Set multiple response headers in one go
* `res.status(codeNo)`: It's chainable like so: res.status(123).send('some msg');
* `res.send`(data): Sets some default headers and sends data where data can be a Number, String, Object, Array or Buffer
* `res.json`(arr|obj): Alternative to _res.send(arr|obj)_ and goes through the json transforms set by the app settings _json replacer_ and _json spaces_
* `res.jsonp`(arr|obj): Send text/javascript via request URL with ?callback=cb
* `res.redirect`(route|url): Defaults to status 302
* `res.cookie`(key, val, options): Modifies the Set-Cookie header
* `res.clearCookie`(key)
* `res.format`(mapOfTypesToHandlers): See [details](http://expressjs.com/en/api.html#res.format)
* ...

# Error handling
Implement error handling as middleware since it applies across the whole app.

```javascript
app.use(function (err, req, res, next) {
    // HANDLE Errors
    console.log(err);
    res.send(500, {msg: 'some app error'}); // print json
    res.render('/errors/500'); //print 500.jade
});

app.get('/my/route', function () {
    // THROW custom errors
    next(new Error('Error type 1'));
});

```

For development-only, use [errorhandler](http://expressjs.com/en/resources/middleware/errorhandler.html)


# Application
* `app.render()`: like _res.render()_ but doesn't auto-send the rendered template to the client.
It renders the template string which you can then use to your liking (eg. send it via [sendgrid email](https://www.npmjs.com/package/sendgrid) )



[#]: -------------------------------------------------------------------
(These are reference links used in the body of this note and get stripped out when the
 markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[nodecasts-httpclient]: <https://courses.nodecasts.io/courses/introduction-to-node-js/lectures/1119972>
[nodecasts-express]: <https://courses.nodecasts.io/courses/express-js>
[changes3to4]: <http://expressjs.com/en/guide/migrating-4.html#changes>
