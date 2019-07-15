import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-input-person',
  templateUrl: './person-input.component.html',
  styleUrls: ['./person-input.component.css']
})

export class PersonInputComponent {
  @Output() personEmitter = new EventEmitter<string>();
  personInputComponent;
  onClick(){
    console.log(this.personInputComponent);
    this.personEmitter.emit(this.personInputComponent);
    this.personInputComponent = '';
  }
}
