function run() {
    console.log('Called %s()', arguments.callee.name);
}

exports.run = run;