import { Component, OnInit } from '@angular/core';

@Component({
  selector: '[app-servers]',
  template: `
  <div class="app-server"></div>
  <div class="app-server"></div>
  <div class="app-server"></div>
  {{variavel}}`,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel = 'teste';
  constructor() { }

  ngOnInit() {
  }

}
