window.addEventListener(
    'load',
    () => {
        mapedPeople = forEachPeople();
        
        console.log(mapedPeople);
        console.log(filterPeople('Minas Gerais'));
        console.log(doReduce());
        console.log(findPeople('David'));
        console.log(somePeople('Amazonas'));
        console.log(everyPeople('BR'));
        console.log(sortPeople('A'));
    }
);
var mapedPeople;

const sortPeople = letter =>   
mapedPeople
    .map(
      person =>{
          return { 
              name: person.name 
            }
      }
    )
    .filter(
        person => true
    )
    .sort(
        (person_a, person_b) => person_a.name.length - person_b.name.length
    );

const everyPeople = 
    nat => people.results.every(
        person => person.nat === nat
    );

const somePeople = 
    state => people.results.some(
        person => person.location.state === state
    );

const findPeople = (firstName) => {
    return people.results.find(
        person => person.name.first === firstName 
    );
}

const mapPeople = () => {
    return people.results.map( 
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