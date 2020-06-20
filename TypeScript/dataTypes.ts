// Number

var decimalNumber: number = 12.00;
var hexaNumber: number = 0xdeadcafe;
var octaNumber: number = 0o377;
var binaryNumber: number = 0b10101010;

console.log(decimalNumber);
console.log(hexaNumber);
console.log(octaNumber);
console.log(binaryNumber);

// String
var nameDev: string ="David";
console.log(nameDev+" Meth");

// Boolean
var flag: boolean = true;
console.log(flag);

// Void
function hello():void
{
    console.log('This is welcome msg'); 
};

// Null
var nula:null = null;

// Fixo
var fixada:'ABC'|'DEF' = 'ABC';

// Undefined
var indefinido:undefined = undefined;

// Any Type
var val:any = 'Hi';

function consol(x: any, y:any){
    console.log(x+y);
};

consol('David','Brenda');
consol(1,2);