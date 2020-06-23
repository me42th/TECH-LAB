function display(variavel) {
    console.log('display');
    console.log(variavel);
}
function sum(x, y) {
    console.log('sum');
    return x + y;
}
var num = function (x, y) {
    console.log('num');
    return sum(x, y);
};
function optional(x) {
    console.log(x);
}
var arrow = function (x) { return console.log(x); };
var defaultValue = function (x) {
    if (x === void 0) { x = 'default'; }
    return console.log(x);
};
function restArgs() {
    var name = [];
    for (var _i = 0; _i < arguments.length; _i++) {
        name[_i] = arguments[_i];
    }
    console.log(name);
    return name.join(' ');
}
optional();
optional(null);
display(num(10, 20));
defaultValue();
defaultValue('other');
console.log(restArgs('1'));
console.log(restArgs('1', '2'));
console.log(restArgs('1', '2', '3'));
console.log(restArgs('1', '2', '3', '4'));
