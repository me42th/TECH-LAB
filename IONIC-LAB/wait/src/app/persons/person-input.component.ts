import { Component } from '@angular/core';
import { PersonsService } from './persons.service';
@Component({
  selector: 'app-input-person',
  templateUrl: './person-input.component.html',
  styleUrls: ['./person-input.component.css']
})

export class PersonInputComponent {
  constructor(private prsService: PersonsService){}

  personInputComponent;

  onClick(){
    console.log(this.personInputComponent);

    this.prsService.addPersons(this.personInputComponent);
    this.personInputComponent = '';
  }
}
