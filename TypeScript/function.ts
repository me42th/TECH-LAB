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

optional();
optional(null);

display(num(10,20));