import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class PersonsService {
  persons = ['Maria', 'Antonio', 'João'];

  addPersons($var: string) {
    this.persons.push($var);
    console.log(this.persons);
  }
}
