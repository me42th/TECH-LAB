import { Component, Output, EventEmitter } from '@angular/core';

@Component ({
  selector: 'app-input-person',
  templateUrl: './person-input.component.html',
  styleUrls: ['./person-input.component.css']
})


export class PersonInputComponent {
  @Output() personCreated = new EventEmitter<string>();
  enteredPersonName: string = '';
  onCreatedPerson() {
    console.log(this.enteredPersonName);
    this.personCreated.emit(this.enteredPersonName);
    this.enteredPersonName = '';
  }
  onCreatePerson(personName: string) {
    console.log('Create a person here: '+personName);
  }
}
