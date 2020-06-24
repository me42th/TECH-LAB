var Animal = /** @class */ (function () {
    function Animal(classification, species) {
        this.classification = classification;
        this.species = species;
    }
    Animal.prototype.display = function () {
        console.log(this.classification + ' ' + this.species);
    };
    return Animal;
}());
var bicho = new Animal('Ave', 'Galinha');
bicho.display();
