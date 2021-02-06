import { Component } from '@angular/core';
@Component({
  selector:"[app-server]",
  templateUrl:"./server.component.html",
  styles: [
    `p {
      padding-left: 4px
    }`,
    `
    .online {
      color: white
    }
    `,
    `
    .offline {
      color: blue
    }
    `
  ]
})

export class ServerComponent{
  serverID: number = 10;
  serverStatus: string = 'offline';
  constructor(){
   this.serverStatus = Math.random() > 0.5?'online':'offline';
  }
  getServerStatus(){
    return this.serverStatus;
  }
  getColor(){
    return this.serverStatus == 'online'?'green':'red';
  }
}
