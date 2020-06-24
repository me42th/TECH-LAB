class Animal{

    classification: 'Mamifero' | 'Ave' | 'Reptil';
    species: string;

    constructor(classification: 'Mamifero' | 'Ave' | 'Reptil', species: string){
        this.classification = classification;
        this.species = species;
    }

    display():void{
        console.log(this.classification+' '+this.species);
    }

}

var bicho = new Animal('Ave','Galinha');

bicho.display();