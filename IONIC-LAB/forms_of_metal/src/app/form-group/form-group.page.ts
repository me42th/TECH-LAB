import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-form-group',
  templateUrl: './form-group.page.html',
  styleUrls: ['./form-group.page.scss'],
})
export class FormGroupPage implements OnInit {

  constructor() { }
  customDayShortNames = ['s\u00f8n', 'man', 'tir', 'ons', 'tor', 'fre', 'l\u00f8r'];
  ngOnInit() {
  }

}
