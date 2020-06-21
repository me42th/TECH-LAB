var i:number = 1;

while(i <= 20){
    console.log(i++);
}

do{ 
    console.log(--i);
}while(i > 1);

for(var i: number = 1; ;console.log(i++)){
    if(i == 20){
        break;
    }
    if(i%2!==0){
        continue;
    }
    console.log('par');
}
