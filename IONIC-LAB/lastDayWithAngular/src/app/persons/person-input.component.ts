import { Component } from '@angular/core';
import { PersonService } from './person.service';
@Component({
  selector: 'app-person-input',
  templateUrl: './person-input.component.html',
  styleUrls: ['./person-input.component.css']
})
export class PersonInputComponent{
  enteredPerson: string;
  constructor(private prsService: PersonService){}
  onClickGo() {
    console.log(this.enteredPerson);
    this.prsService.addPerson(this.enteredPerson);
    this.enteredPerson = '';
  }
}
