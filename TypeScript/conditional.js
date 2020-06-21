var age = 2;
if (age >= 18) {
    console.log('Adulto');
}
else if (age >= 10) {
    console.log('Adolescente');
}
else {
    console.log('Criança');
}
age >= 18 ?
    console.log('Adulto') :
    age >= 10 ?
        console.log('Adolescente') :
        console.log('Criança');
switch (age) {
    case 33:
        console.log('Gzuis');
        break;
    case 42:
        console.log('Universo e Essas Coisas');
        break;
    default:
        console.log('Outra Coisa');
}
