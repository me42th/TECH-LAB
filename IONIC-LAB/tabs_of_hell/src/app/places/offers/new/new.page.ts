import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-new',
  templateUrl: './new.page.html',
  styleUrls: ['./new.page.scss'],
})
export class NewPage implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  onCreateOffer(){
    console.log("create something");
  }

} 
