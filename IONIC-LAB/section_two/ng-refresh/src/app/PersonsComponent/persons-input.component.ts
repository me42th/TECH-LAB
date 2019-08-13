import { Component } from '@angular/core';

@Component({
  selector: 'persons-input',
  templateUrl: './persons-input.component.html',
  styleUrls: ['./persons-input.component.css']
})
export class PersonsInputComponent{
  onCreatePerson(){
    console.log('Created Person');
  }
}
