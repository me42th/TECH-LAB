import { Component } from '@angular/core';
import { DbService } from '../db.service';


@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {


  constructor(private db: DbService) {

  }

  onClick() {
    this.db.store('u1', 'David');
    this.db.show();
  }

}
