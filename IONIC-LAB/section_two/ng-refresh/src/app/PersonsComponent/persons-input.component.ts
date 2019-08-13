import { Component} from '@angular/core';
import { PersonsService } from './persons.service';

@Component({
  selector: 'persons-input',
  templateUrl: './persons-input.component.html',
  styleUrls: ['./persons-input.component.css']
})

export class PersonsInputComponent{

  email: string = '';
  otherEmail: string = '';

  constructor(
    private prsService: PersonsService
  ){}

  onCreatePerson(name: string){
    console.log(name + '|' + this.email + '|' + this.otherEmail);
    this.prsService.addPerson(name);
  }
}
