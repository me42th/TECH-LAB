# Capitulo 2 | [VOLTAR](../readme.md)


## TYPES IN JS
```
> typeof(15);
'number'
> typeof(true);
'boolean'
> typeof({});
'object'
> typeof(null);
'object'
> typeof(a);
'undefined'

// false, 0, null, undefined == falsy

// true, 1, [1], {id: 1} == truthy
```

## CONSOLE
```
console.log(123)
console.error(456)
console.warn(789)
console.table({id: 23})
console.dir(document.getElementById('id'))
```

## MENOR/MAIOR
```
// retorno +, a > b
// retorno -, b > a
// retorno 0, equals
function compareNumbers(a,b){
    return a - b;
}
```

## ACESSAR ELEMENTOS DO DOM
```
var firstParagraph = document.querySelector('p');

var mediaWiki = document.querySelector('.mediaWiki');

var content = document.querySelector('#font');
content.textContent = 'Novo Valor';

var all_content = document.querySelectorAll('p');
var array_all_content = Array.from(all_content);
```

## MANIPULAR CSS COM JS
```
var titulo = document.querySelector('.page-title');
titulo.style.color = 'green';
```