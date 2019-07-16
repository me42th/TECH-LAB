import { Component, OnInit } from '@angular/core';
import { PersonService } from './person.service';
@Component({
  selector: 'app-person',
  templateUrl: './persons.component.html',
  styleUrls: []
})
export class PersonsComponent implements OnInit{
  personsList: string[];
  constructor(private prsService: PersonService){

  }
  ngOnInit(){
    this.personsList = this.prsService.persons;
  }
}
