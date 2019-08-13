import { Component, Output, EventEmitter } from '@angular/core';


@Component({
  selector: 'persons-input',
  templateUrl: './persons-input.component.html',
  styleUrls: ['./persons-input.component.css']
})
export class PersonsInputComponent{
  @Output() personCreate = new EventEmitter<string>();
  email: string = '';
  otherEmail: string = '';
  onCreatePerson(name: string){
    this.personCreate.emit(name);
    console.log(name + '|' + this.email + '|' + this.otherEmail);
  }
}
