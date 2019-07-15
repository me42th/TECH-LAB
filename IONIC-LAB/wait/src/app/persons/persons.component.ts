import { Component, OnInit } from '@angular/core';
import { PersonsService } from './persons.service';

@Component({
  selector: 'app-persons',
  templateUrl: './persons.component.html',
  styleUrls: ['./persons.component.css']
})

export class PersonsComponent implements OnInit{
  personsList: string[];

  constructor(private prsService: PersonsService){

  }

  ngOnInit(){
    this.personsList = this.prsService.persons;
  }
}
