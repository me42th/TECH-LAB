import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-servers',
  template: `
  <app-server></app-server>
  <app-server></app-server>
  <app-server></app-server>
  {{variavel}}`,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel = 'teste';
  constructor() { }

  ngOnInit() {
  }

}
