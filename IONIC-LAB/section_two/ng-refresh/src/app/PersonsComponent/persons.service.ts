import { Injectable } from '@angular/core';

@Injectable(
  {providedIn: 'root'}
)
export class PersonsService{
  persons: string[] = ['Max','Anna','David'];

  addPerson(name: string){
    this.persons.push(name);
  }
}
