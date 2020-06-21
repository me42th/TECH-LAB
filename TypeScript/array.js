var fruits = ['apple', 'mango', 'banana'];
var color = ['red', 'green', 'blue'];
var week = [
    1, 'Domingo',
    2, 'Segunda',
    3, 'Terça',
    4, 'Quarta',
    5, 'Quinta',
    6, 'Sexta',
    7, 'Sábado'
];
var numbers = [1, 'Um', 2, 'Dois', 3, 'Três'];
console.log(week);
console.log(color);
console.log(fruits);
for (var cont = 0; cont < numbers.length; cont++) {
    console.log(' | ' + numbers[cont++] + ' | ' + numbers[cont]);
}
// INDICE
for (var day in week) {
    console.log(day);
}
// ELEMENTO
for (var _i = 0, week_1 = week; _i < week_1.length; _i++) {
    var day = week_1[_i];
    console.log(day);
}
var pessoas = [
    ['Brenda', 23],
    ['David', 30],
    ['Murilo', 10]
];
for (var _a = 0, pessoas_1 = pessoas; _a < pessoas_1.length; _a++) {
    var pessoa = pessoas_1[_a];
    console.log(pessoa);
}
