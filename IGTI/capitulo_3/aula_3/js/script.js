window.addEventListener(
    'load',
    () => {
        mapedPeople = mapPeople();
        console.log(mapedPeople);
        console.log(filterPeople('David'));
    }
);
var mapedPeople;

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

const filterPeople = (firstName) => {
    return people.results.filter(
        person => person.name.first === firstName
    );
}