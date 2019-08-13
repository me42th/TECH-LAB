import { Component, OnInit, OnDestroy} from '@angular/core';
import { PersonsService } from './persons.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-person',
  templateUrl: './persons.component.html'
})
export class PersonsComponent implements OnInit, OnDestroy {

  constructor(
    private prsService: PersonsService
    ) {  }

  personSubs: Subscription;

  personsList: string[];

  ngOnInit() {
    this.prsService.fetchPersons();
    this.personsList = this.prsService.persons;
    this.personSubs = this.prsService.personsChanged.subscribe( persons => {
      this.personsList = persons;
    });
  }

  ngOnDestroy() {
    this.personSubs.unsubscribe();
  }

  onClick(name: string) {
    this.prsService.rmvPerson(name);
  }
}
