import { Component } from '@angular/core';

@Component({
  selector: '.app-server',
  //templateUrl: './server.component.html'
  template: `
  <p
  [ngStyle]="{
    backgroundColor: color()
  }"
  [ngClass]="{
    online: serverStatus === 'online'
  }"
  >Server with ID {{id}} IS {{serverStatus}}
  </p>`,
  styles: [`
  .online{
    color: white
  }
  `]
})
export class ServerComponent {
 static serverID: number = 1;
 private _id: number = ServerComponent.serverID++;
 private _serverStatus: 'offline' | 'online' = 'offline';

 color() {
   return this.serverStatus === 'online' ? 'green' : 'red';
 }
 constructor() {
   this._serverStatus = Math.random() > 0.5 ? 'online' : 'offline';
 }
 get id() {
   return this._id;
 }
 get serverStatus() {
   return this._serverStatus;
 }
}
