import { Component, OnInit } from '@angular/core';
import { interval } from 'rxjs';
import { tap } from 'rxjs/operators';

@Component({
  selector: '[app-servers]',
  template: `
  <button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flagui(0)">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flagui(1)">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flagui(2)">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flagui(3)">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flagui(4)">Add Server</button>
  &nbsp;<button class="btn btn-primary"
  [disabled]="!allowNewServer"
  (click)="flagui(5)">Add Server</button>
  <div class="app-server" (=> (click))></div>
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
    // interval(100)
    // .subscribe(
    //  value => {

    //    this.numero = value;
    //    this.flag();
    //  }
   // );
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
