import { Component, OnInit } from '@angular/core';

@Component({
  selector: '.app-servers',
  templateUrl: './servers.component.html',
  styleUrls: ['./servers.component.css']
})

export class ServersComponent {
  isAllowedNewServer = false;
  serverCreationStatus = 'No server was created!';
  serverName = '';
  serverCreated = false;
  serverList = ['server','other'];
  constructor() {
    setTimeout(() => this.isAllowedNewServer = true, 2000);
  }

  onCreateServer(){
    this.serverList.push(this.serverName);
    this.serverCreated = true;
    this.serverCreationStatus = 'Server '+this.serverName+' created';
  }
  onUpdateServer(event: any){
    this.serverName = event.target.value;
  }
}
