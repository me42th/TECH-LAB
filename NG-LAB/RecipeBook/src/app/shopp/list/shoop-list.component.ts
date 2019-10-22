import { Component, OnInit } from '@angular/core';

@Component({
  // tslint:disable-next-line: component-selector
  selector: 'shopp-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ShoopListComponent implements OnInit {

  constructor() { }

  ngOnInit() {
    console.log('teste');
  }

}
