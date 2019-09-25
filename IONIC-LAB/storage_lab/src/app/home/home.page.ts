import { Component } from '@angular/core';
import { DbService } from '../db.service';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})

export class HomePage {

  nomeInput: FormControl = new FormControl(null, {updateOn: 'change'});
  lista: any[];

  form: FormGroup = new FormGroup({
    nome : this.nomeInput
  });

  constructor(private db: DbService) {
    this.db.observable
    .subscribe( value => this.lista = value);
  }

  onClick() {
    this.db.store(this.nomeInput.value);
    this.db.show();
    this.nomeInput.setValue('');
  }

  onDel(value: string) {
    this.db.del(value);
  }

}
