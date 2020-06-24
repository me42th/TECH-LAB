function display(variavel: any){
    console.log('display');
    console.log(variavel);
}

function sum(x: number, y: number):number{
    console.log('sum');
    return x+y;
}

var num =  function (x:number, y:number):number {
    console.log('num');
    return sum(x,y);
}

function optional(x?:never|null){
    console.log(x);
}

var arrow = (x:string) =>  console.log(x); 

var defaultValue = (x:string = 'default') =>   console.log(x);

function restArgs(...name:Array<string>): string{
    console.log(name);
    return name.join(' ');
}

optional();
optional(null);

display(num(10,20));

defaultValue();
defaultValue('other');

console.log(restArgs('1'));
console.log(restArgs('1','2'));
console.log(restArgs('1','2','3'));
console.log(restArgs('1','2','3','4'));
