import { Component } from '@angular/core';

@Component({
  selector: '.app-server',
  //templateUrl: './server.component.html'
  template: '<p>Server with ID {{serverID}} IS {{getServerStatus()}} </p>',
})
export class ServerComponent {
 serverID: number = 10;
 serverStatus: 'offline' | 'online' = 'offline';
 getServerStatus() {
   return this.serverStatus;
 }
}
