var people: [number,string] = [0,''];

people.push(1990,'David');
people.push(2010,'Murilo');

console.log(people);

people.pop();
people.pop();

console.log(people);

people[0] = 1996;
people[1] = 'Brenda';

console.log(people);

var person: [number,string][] = [[30,'David'],[23,'Brenda'],[10,'Murilo']];

console.log(person);