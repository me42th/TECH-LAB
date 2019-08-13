import { Component, OnInit} from '@angular/core';
import { PersonsService } from './persons.service';

@Component({
  selector: 'app-person',
  templateUrl: './persons.component.html'
})
export class PersonsComponent implements OnInit{

  constructor(
    private prsService: PersonsService
    ){  }

  personsList: string[];

  ngOnInit(){
    this.personsList = this.prsService.persons;
  }

  onClick(name: string){
    this.prsService.rmvPerson(name);
  }
}
