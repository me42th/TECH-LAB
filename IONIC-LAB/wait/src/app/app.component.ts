import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  persons = ['Maria', 'Antonio', 'João'];

  changePersons($var: string){
    this.persons.push($var);
  }
}
