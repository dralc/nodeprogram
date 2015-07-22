//function repeat(operation, num) {
//    for (var i = 0; i < num; i++) {
//        operation.call();
//    }
//}

function repeat(operation, num) {
    if (num <= 0) return
    operation()

    repeat(operation, --num)
}


module.exports = repeat;
