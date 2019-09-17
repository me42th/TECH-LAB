import { Component, OnInit } from '@angular/core';
import { TuxComponent } from './tux/tux.component';

@Component({
  selector: 'app-navrout',
  templateUrl: './navrout.page.html',
  styleUrls: ['./navrout.page.scss'],
})
export class NavroutPage implements OnInit {

  constructor() { }
  root: TuxComponent;
  ngOnInit() {
  }

}
