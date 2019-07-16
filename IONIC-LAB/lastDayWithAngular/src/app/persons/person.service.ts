import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class PersonService {
  persons = ["Ana", "Maria", "Jose"];
  addPerson(prs: string) {
    this.persons.push(prs);
    console.log(this.persons);
  }
}
