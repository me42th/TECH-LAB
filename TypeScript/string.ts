var mystring: string = "Welcome to TypeScript";
let otherstring = "                             My Brother                   ";

console.log(mystring.charAt(0));

console.log(otherstring);
console.log(mystring);
console.log(otherstring = ' '+otherstring.trim());

console.log(mystring = mystring.concat(otherstring));

console.log(mystring = mystring.replace('Type','Java'));

console.log(mystring.split(' '));
console.log(mystring.split(' ',1));
console.log(mystring.split(' ',3));

console.log(mystring.substring(0,7));

console.log(mystring.toUpperCase());

console.log(mystring.toLowerCase());


