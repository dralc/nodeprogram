/**
 * Returns the num of arguments that DIRECTLY have the property 'quack'
 *
 * @params {*} takes any number of arguments
 * @returns {Number}
 */
function duckCount() {

    //reduce, map, forEach, filter, every/some

    var ducks = Array.prototype.filter.call(arguments, function (arg, i, ar) {
        return Object.prototype.hasOwnProperty.call(arg, 'quack');
    });

    return ducks.length;
}
module.exports = duckCount;
//duckCount(a, b, c, d, ...)