import { Injectable } from "@angular/core";
import { Subject } from 'rxjs';

@Injectable({ providedIn: "root" })
export class PersonService {
  personsChanged = new Subject<string[]>();
  persons = ["Ana", "Maria", "Jose"];

  addPerson(prs: string) {
    this.persons.push(prs);
    this.personsChanged.next(this.persons);
  }

  rmvPerson(prs: string){
    this.persons = this.persons.filter(person => { return person !== prs});
    this.personsChanged.next(this.persons);
  }
}
