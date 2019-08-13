import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable(
  {providedIn: 'root'}
)
export class PersonsService{
  persons: string[] = ['Max','Anna','David'];
  personsChanged = new Subject<string[]>();
  addPerson(name: string){
    this.persons.push(name);
    this.personsChanged.next(this.persons);
    console.log(this.persons);
  }

  rmvPerson(name: string){
    console.log(name);
    this.persons = this.persons.filter( person =>
      {
        return person !== name ;
      });
    this.personsChanged.next(this.persons);
    console.log(this.persons);
  }
}
