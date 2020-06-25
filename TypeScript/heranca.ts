class Person{
    name: string;

    isFree():boolean{
        return true;
    }

    constructor(name: string){
        this.name = name;
        console.log(this.name);
    }
}

class Employee extends Person{

    isFree():boolean{
        return false;
    }

    id:number;
    constructor(id:number,name: string){
        super(name);
        this.id = id;
        console.log(this.id);
    }
}

class Child extends Person{

    isFree():boolean{
        return true;
    }

    constructor(name: string){
        super(name);
    }
}

var job = new Employee(42,'David Meth');
var chil = new Child('Murilo');

console.log(job.isFree());
console.log(chil.isFree());