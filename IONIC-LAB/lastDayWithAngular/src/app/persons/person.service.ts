import { Injectable } from "@angular/core";
import { Subject } from "rxjs";
import { HttpClient } from "@angular/common/http";
import { map } from "rxjs/operators";

@Injectable({ providedIn: "root" })
export class PersonService {
  personsChanged = new Subject<string[]>();
  persons: string[] = [];

  constructor(private http: HttpClient) {}

  fetchPerson() {
    this.http
      .get<any>("https://swapi.co/api/people")
      .pipe(
        map(resData => {
          return resData.results.map(character => character.name);
        })
      )
      .subscribe(transformedData => {
        this.personsChanged.next(this.persons = transformedData);
      });
  }

  addPerson(prs: string) {
    this.persons.push(prs);
    this.personsChanged.next(this.persons);
  }

  rmvPerson(prs: string) {
    this.persons = this.persons.filter(person => {
      return person !== prs;
    });
    this.personsChanged.next(this.persons);
  }
}
