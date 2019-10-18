import { Component, OnInit } from '@angular/core';


@Component({
  selector: '[app-servers]',
  template: `
  <label>Server Name</label>
  <input
  type="text"
  class="form-control"
  (input)="onUpdateServerName($event)">
  <button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flagui(5)">Add Server</button>
  <div class="app-server" ></div>
  <div class="app-server"></div>
  <div class="app-server"></div>
  <div [innerText]="variavel+' '+numero"></div>`,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel = 'VALOR ';
  numero = 0;
  allowNewServer = true;
  constructor() {

  }

  onUpdateServerName(event: any) {
    console.log(event);
    this.variavel = 'VALOR ' + (event.target as HTMLInputElement).value;
  }

  flagui(value: number) {

    alert('triggered by ' + value);
    this.flag();
  }
  flag() {
    this.allowNewServer = !this.allowNewServer;
  }
  ngOnInit() {
  }

}
