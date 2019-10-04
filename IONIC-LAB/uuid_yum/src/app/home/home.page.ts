import { UniqueDeviceID } from '@ionic-native/unique-device-id/ngx';
import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  data = ':D ';
  error = ':P ';
  constructor(private uuid: UniqueDeviceID) {
    this.uuid.get()
    .then( value => this.data = '' + value)
    .catch(value => this.error = '' + value);
  }

}
