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
  [disabled]="false"
  (click)="flagui($event)">Add Server</button>
  <div class="app-server" *ngFor="let server of servers">
    {{server}}
  </div>
  <div [innerText]="variavel" *ngIf="loser; else noServer"></div>
  <ng-template #noServer>
    <div>
      No Click
    </div>
  </ng-template>
  `,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel: string;
  loser: true | false = false;
  allowNewServer = true;
  servers = ['Teste', 'Outro Teste'];
  constructor() {

  }

  onUpdateServerName(event: any) {
    console.log(event);
    this.variavel = 'VALOR ' + (event.target as HTMLInputElement).value;
  }

  flagui(value: any) {
    this.loser = true;
    this.servers.push(value);
    this.flag();
  }
  flag() {
    this.allowNewServer = !this.allowNewServer;
  }
  ngOnInit() {
  }

}
