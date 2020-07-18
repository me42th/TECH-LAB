var a = 1;
var b = 0;
var texto; 
switch(texto = equals_a_b(a,b)?a_menor_b():equals_b_a(a,b)?b_menor_a():isonomia()){
    case 'A':
       texto = 'A É MENOR';
    break;
    case 'B':
        texto = 'B É MENOR';
    break;   
    case 'C':
        texto = 'IGUAIS';
    break
}


if (a < b || b < a){
    console.error(texto);
} 
else{
    console.log(texto);
}

var vogal = 'e';

var texto_vogal = '';

switch(vogal){
    case 'a':
        texto_vogal = texto_vogal+' a';
    case 'e':
        texto_vogal = texto_vogal+' e';
    case 'i':
        texto_vogal = texto_vogal+' i';
    case 'o':
        texto_vogal = texto_vogal+' o';
    case 'u':
        texto_vogal = texto_vogal+' u';
    default:
        texto_vogal = '|'+texto_vogal;    
}

switch(vogal){    
    case 'u':
        texto_vogal = 'o '+texto_vogal;
    case 'o':
        texto_vogal = 'i '+texto_vogal;
    case 'i':
        texto_vogal = 'e '+texto_vogal;
    case 'e':
        texto_vogal = 'a '+texto_vogal;    
}

console.warn(texto_vogal);

function equals_a_b(a , b){
    console.error('BBMP');
    return a < b;
}

function equals_b_a(a , b){
    console.warn('Filma eu');
    return a > b;
}

function a_menor_b(){
    var tag = document.querySelector('h1');
    tag.textContent = 'A MENOR QUE B';
    return 'A';
}

function b_menor_a(){
    var id = document.getElementById('idt');
    id.textContent = 'B MENOR QUE A';
    return 'B';
}

function isonomia(){
    var id = document.getElementById('idt');
    id.textContent = 'ISONOMIA DETECTADA';

    var tag = document.querySelector('h1');
    tag.textContent = 'ISONOMIA DETECTADA';
   
    return 'C';
}



 


