const arr1 = ['abc','def','ghi'];
console.log(arr1);
const arr2 = ['123','456','789'];
console.log(arr2);
const arr3 = [...arr1,...arr2];
console.log(arr3);
const arr4 = [arr1, ...arr2, arr3];
console.log(arr4);

console.log(varargs(...arr2));

function varargs(...values){    
    return values.reduce((acc,cur) => acc+cur,0);
}

var objeto = {id: 123,name: 'David'};

var pessoa = {name} = objeto;
console.log(objeto);
console.log(pessoa);