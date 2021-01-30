import { Component, OnInit } from '@angular/core';

@Component({
  selector: '.app-servers',
  template: `
    <div app-server></div>
    <div app-server></div>
  `,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

}
