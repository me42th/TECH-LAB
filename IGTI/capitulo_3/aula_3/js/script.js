window.addEventListener(
    'load',
    () => {
        mapedPeople = forEachPeople();
        
        console.log(mapedPeople);
        console.log(filterPeople('Minas Gerais'));
        console.log(doReduce());
        console.log(findPeople('David'));
    }
);
var mapedPeople;

const findPeople = (firstName) => {
    return people.results.find(
        person => person.name.first === firstName 
    );
}

const mapPeople = () => {
    let baianos = filterPeople('Bahia');
    return baianos.map( 
        person => {
            return {
                name: `${person.name.first} ${person.name.last}`,
                email: person.email 
            }
        }
    );
}

const forEachPeople = () => {
    let arrayOfPeople = mapPeople();

    arrayOfPeople.forEach( 
        (person,key) => 
        person.id = key
    );
    return arrayOfPeople;
}

const doReduce = () => {
    return mapedPeople.reduce(
        (acumulator,current) => acumulator+current.name.length+current.email.length,0 
    );
}

const filterPeople = (state) => {
    return people.results.filter(
        person => person.location.state === state
    );
}