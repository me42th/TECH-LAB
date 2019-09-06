import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-form-group',
  templateUrl: './form-group.page.html',
  styleUrls: ['./form-group.page.scss'],
})
export class FormGroupPage implements OnInit {

  constructor() { }
  onCreate() {
    console.log('go johnny, go');
    alert('hit the road jack');
  }
  ngOnInit() {

  }
}
