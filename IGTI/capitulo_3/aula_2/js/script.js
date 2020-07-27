'use strict';

window.addEventListener(
    'load',
    () => {
        funcao();
    }
);

const funcao = (valor = 10) => {
    for(var i = 0;i < valor; i++){
        console.log(i);
    }
    console.error(`VAR ${i}`);
    for(let j = 0;j < valor; j++){
        console.log(j);
    }
    console.error(`LET ${j}`);
}