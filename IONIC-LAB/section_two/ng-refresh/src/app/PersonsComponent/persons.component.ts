import { Component} from '@angular/core';
import { PersonsService } from './persons.service';

@Component({
  selector: 'app-person',
  templateUrl: './persons.component.html'
})
export class PersonsComponent{
  personsList: string[];

  constructor(prsService: PersonsService){
    this.personsList = prsService.persons;
  }
}
