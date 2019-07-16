import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class PersonService {
  persons = ["Ana", "Maria", "Jose"];

  addPerson(prs: string) {
    this.persons.push(prs);
    console.log(this.persons);
  }

  rmvPerson(prs: string){
    this.persons = this.persons.filter(person => { return person !== prs});
    console.log(this.persons);
  }
}
