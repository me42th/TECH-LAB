import { Component, OnInit } from '@angular/core';

@Component({
  selector: '.app-servers',
  templateUrl: './servers.component.html',
  styleUrls: ['./servers.component.css']
})

export class ServersComponent {
  isAllowedNewServer = false;
  constructor() {
    setTimeout(() => this.isAllowedNewServer = true, 2000);
  }
}
