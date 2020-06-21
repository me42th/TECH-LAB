var fruits:string[] = ['apple','mango','banana'];
var color:Array<string> = ['red','green','blue'];

var week:Array<string | number> = [
                                        1,'Domingo',
                                        2,'Segunda',
                                        3,'Terça',
                                        4,'Quarta',
                                        5,'Quinta',
                                        6,'Sexta',
                                        7,'Sábado'
                                    ];

var numbers:(string | number)[] = [1,'Um',2,'Dois',3,'Três'];

var armario:true & false;

console.log(week);
console.log(color);
console.log(fruits);

for(let cont: number = 0; cont < numbers.length ; cont++){
    console.log(' | '+numbers[cont++]+' | '+numbers[cont]);
}

// INDICE
for(let day in week){
    console.log(day);
}

// ELEMENTO
for(let day of week){
    console.log(day);
}

var pessoas: Array<Array<string|number>> = [
                                            ['Brenda',23],
                                            ['David',30],
                                            ['Murilo',10]
                                        ];
for(let pessoa of pessoas){
    console.log(pessoa);
}