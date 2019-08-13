import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';

@Injectable(
  {providedIn: 'root'}
)
export class PersonsService{
  persons: string[] = ['Max','Anna','David'];
  personsChanged = new Subject<string[]>();

  constructor(
    private http: HttpClient
  ){}

  fetchPersons(){

    // this.http.post
    //this.http.get<any>('https://randomuser.me/api/').subscribe( resData => {
    //  console.log(resData);
    //});

    this.http.get<any>('https://randomuser.me/api/?results=10')
    .pipe( map( resData => {
      return resData.results.map( people => people.name.first )
    }))
    .subscribe( transData => {
      this.personsChanged.next(transData);
    });
  }

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
