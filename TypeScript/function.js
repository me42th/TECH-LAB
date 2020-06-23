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
optional();
optional(null);
display(num(10, 20));
