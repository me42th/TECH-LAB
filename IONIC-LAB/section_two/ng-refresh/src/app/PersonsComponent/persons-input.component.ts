import { Component } from '@angular/core';

@Component({
  selector: 'persons-input',
  templateUrl: './persons-input.component.html',
  styleUrls: ['./persons-input.component.css']
})
export class PersonsInputComponent{
  email: string = '';
  otherEmail: string = '';
  onCreatePerson(name: string){
    console.log(name + '|' + this.email + '|' + this.otherEmail);
  }
}
