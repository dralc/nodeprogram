var th = require('through2');

var transform_stm = th(write, end);

function write(buffer, encoding, next) {
    this.push(buffer.toString().toUpperCase());
    next();
}

function end(done) {
    done();
}

process.stdin
    .pipe(transform_stm)
    .pipe(process.stdout);

