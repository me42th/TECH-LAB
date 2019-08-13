import { Injectable } from '@angular/core';

@Injectable(
  {providedIn: 'root'}
)
export class PersonsService{
  persons: string[] = ['Max','Anna','David'];

  addPerson(name: string){
    this.persons.push(name);
    console.log(this.persons);
  }

  rmvPerson(name: string){
    console.log(name);
    this.persons = this.persons.filter( person =>
      {
        return person !== name ;
      });
    console.log(this.persons);
  }
}
