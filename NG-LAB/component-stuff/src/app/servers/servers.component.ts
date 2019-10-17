import { Component, OnInit } from '@angular/core';
import { interval } from 'rxjs';

@Component({
  selector: '[app-servers]',
  template: `
  <button class="btn btn-primary"
  [disabled]="allowNewServer"
  (click)="flag()">Add Server</button>
  <div class="app-server"></div>
  <div class="app-server"></div>
  <div class="app-server"></div>
  {{variavel}}`,
  styleUrls: ['./servers.component.css']
})
export class ServersComponent implements OnInit {
  variavel = 'teste';
  allowNewServer = false;
  constructor() {
    interval(2000).subscribe(
      () => {
        if (this.allowNewServer) {
          this.allowNewServer = false;
        }
      }
   );
  }
  flag() {
    this.allowNewServer = !this.allowNewServer;
  }
  ngOnInit() {
  }

}
