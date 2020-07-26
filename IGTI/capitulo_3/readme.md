# Capitulo 3 | [VOLTAR](../readme.md)

## Arrow Function
```
const imagineUmNomeBacanaQueFazAlgo = (algo) => console.error(algo); 

window.addEventListener(
    'load',
    () => {
        console.log('Filma Eu');   
    }
)
```

## Template Literals
```
let algo = '123';

// Template Literals (crase)
let coisa = `ab ${algo}`;

//Concatenacao Normal
let variavel = `abc'+coisa;
```

## JS Informando Erros
```
'use strict';
```

## Arrays
- map() -> gera novo array transformando dados
- fitler() -> gera um novo array filtrando elementos com base em proposição
- foreach() -> percorre todos os elementos do array, aplicando lógica
- reduce() -> realiza calculo iterativo com base em proposições
- find() -> encontra elementos com base em proposições
- some() -> verifica se há pelo menos um elemento que atenda a proposição
- every() -> verifica se todos os elementos atendem a proposição
- sort() -> ordena o array com base em algum critério 

**map()**
```
const mapPeople = () => {
    return people.results.map( 
        person => {
            return {
            name: `${person.name.first} ${person.name.last}`,
            email: person.email 
            }
        }
    );
}
```

**sort()**
```
const sortPeople = letter =>   
mapedPeople
    .map(
      person =>{
          return { 
              name: person.name 
            }
      }
    )
    .filter(
        person => person.name.startsWith(letter)
    )
    .sort(
        (person_a, person_b) => person_a.name.localeCompare(person_b.name)
        //  (person_a, person_b) => person_a.name.length - person_b.name.length
    );
```

**every()**
```
const everyPeople = 
    nat => people.results.every(
        person => person.nat === nat
    );
```

**some()**
```
const somePeople = 
    state => people.results.some(
        person => person.location.state === state
    );
```

**find()**
```
const findPeople = (firstName) => {
    return people.results.find(
        person => person.name.first === firstName 
    );
}
```

**filter()**
```
const filterPeople = (firstName) => {
    return people.results.filter(
        person => person.name.first === firstName
    );
}
```

**forEach()**
```
const forEachPeople = () => {
    let arrayOfPeople = mapPeople();
    arrayOfPeople.forEach( 
        (person,key) => 
        person.id = key
    );
    return arrayOfPeople;
}
```

**reduce()**
```
const doReduce = () => {
    return mapedPeople.reduce(
        (acumulator,current) => acumulator+current.name.length+current.email.length,0 
    );
}
```

## SPRED OPERATOR [IMPLODE ARRAY]
```
const arr1 = ['abc','def','ghi'];
console.log(arr1);
const arr2 = ['123','456','789'];
console.log(arr2);
const arr3 = [...arr1,...arr2];
console.log(arr3);
const arr4 = [arr1, ...arr2, arr3];
console.log(arr4);
```

## VARARGS 
```
function varargs(...values){    
    return values.reduce((acc,cur) => acc+cur,0);
}
```

## [CALL STACK](https://medium.com/reactbrasil/como-o-javascript-funciona-o-event-loop-e-o-surgimento-da-programa%C3%A7%C3%A3o-ass%C3%ADncrona-5-maneiras-de-18d0b8d6849a)
![CALL STACK](https://miro.medium.com/max/700/1*TozSrkk92l8ho6d8JxqF_w.gif)


## HTTP

**PROMISE**
```
const programador = fetch('https://api.github.com/users/me42th')
.then(
    res => res
        .json()
        .then(data => console.log(data))
        .catch(data => console.error(data))
    )
.catch(
    data => console.error(data)
);
```

**ASYNC/AWAIT**
```
const dev = async (nick) => {
    let dados = await fetch(`https://api.github.com/users/${nick}`); 
    dados = await dados.json();
    console.log(dados);
}
```
