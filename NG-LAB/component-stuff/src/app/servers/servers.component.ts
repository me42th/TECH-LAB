import { Component, OnInit } from '@angular/core';
import { interval } from 'rxjs';
import { tap } from 'rxjs/operators';

@Component({
  selector: '[app-servers]',
  template: `
  <button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flag()">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flag()">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flag()">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flag()">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flag()">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flag()">Add Server</button>
  <div class="app-server"></div>
  <div class="app-server"></div>
  <div class="app-server"></div>
  <div [innerText]="variavel+' '+numero"></div>`,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel = 'VALOR ';
  numero = 0;
  allowNewServer = false;
  constructor() {
    interval(100)
    .subscribe(
      value => {
        this.numero = value;
        this.flag();
      }
   );
  }
  flag() {
    this.allowNewServer = !this.allowNewServer;
  }
  ngOnInit() {
  }

}
