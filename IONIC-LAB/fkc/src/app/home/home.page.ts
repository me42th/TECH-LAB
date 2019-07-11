import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor() {}
  text = 'default';
  state = true;
  onChange(){
    if(this.state){
      this.text = 'other';
      this.state = false;
    }else{
      this.text = 'default';
      this.state = true;      
    }
  }
}
