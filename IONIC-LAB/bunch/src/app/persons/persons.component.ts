import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-person',
  templateUrl: './persons.component.html'

})

export class PersonsComponent {
  @Input() personsList: string[];
}
