import { Component, OnInit } from '@angular/core';

@Component({
  selector: '.app-servers',
  templateUrl: './servers.component.html',
  styleUrls: ['./servers.component.css']
})

export class ServersComponent {
  isAllowedNewServer = false;
  serverCreationStatus = 'No server was created!';
  constructor() {
    setTimeout(() => this.isAllowedNewServer = true, 2000);
  }

  onCreateServer(){
    this.serverCreationStatus = 'Server created';
  }
}
