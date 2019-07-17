import { Component, OnInit, OnDestroy } from '@angular/core';
import { PersonService } from './person.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-person',
  templateUrl: './persons.component.html',
  styleUrls: []
})
export class PersonsComponent implements OnInit, OnDestroy{
  personsList: string[];
  isFetching = false;
  private prsSubs: Subscription;
  constructor(private prsService: PersonService){

  }
  ngOnInit(){
    //this.personsList = this.prsService.persons;
    this.prsService.fetchPerson();
    this.prsSubs = this.prsService.personsChanged.subscribe(persons => {
      this.personsList = persons;
      this.isFetching = false;
    });
    this.isFetching = true;
  }

  ngOnDestroy(){
    this.prsSubs.unsubscribe();
  }

  onClick(person: string){
    this.prsService.rmvPerson(person);
  }
}
