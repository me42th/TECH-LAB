'use strict';

console.log('hey');
funcao();
function funcao(){
    for(var i = 0;i < 20; i++)
        console.log(i);
    console.error(`OLHA EU AQUI ${i}`);
    for(let j = 0;j < 20; j++)
        console.log(j);
    console.error(`OLHA EU AQUI ${j}`);
}