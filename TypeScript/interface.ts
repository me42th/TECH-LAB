
interface IWorker{
    name: string;
    getJob: () => string;
}

var dev:IWorker = {
    name:'David Meth',
    getJob():string{
        return 'Programmer'
    }
}

var enf:IWorker = {
    name: 'Brenda Costa',
    getJob():string{
        return 'Nurse';
    }
}

class Doctor implements IWorker{
    name: string;
    constructor(name: string){
        this.name = name;
    }
    getJob(){
        return 'Doctor';
    }
}

function display(worker: IWorker){
    console.log(worker.getJob());
}

var doc = new Doctor('Murilo Costa');

display(dev);
display(enf);
display(doc);