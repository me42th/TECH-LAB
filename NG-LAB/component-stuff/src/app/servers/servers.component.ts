import { Component, OnInit } from '@angular/core';


@Component({
  selector: '[app-servers]',
  template: `
  <label>Server Name</label>
  <input
  type="text"
  class="form-control"
  (input)="onUpdateServerName($event)"
  placeholder="event binding">
  <input
  type="text"
  class="form-control"
  [(ngModel)]="variavel"
  placeholder="two way">
  <button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flagui(5)">Add Server</button>
  <div class="app-server" ></div>
  <div class="app-server"></div>
  <div class="app-server"></div>
  <div [innerText]="variavel"></div>`,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel: string;

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
