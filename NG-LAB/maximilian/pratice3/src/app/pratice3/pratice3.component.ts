import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-pratice3',
  templateUrl: './pratice3.component.html',
  styles: [`
    .white{
      color: white;
    }
  `]
})
export class Pratice3Component implements OnInit {
  clicks = [];
  constructor() { }

  ngOnInit(): void {
  }

  getMargin(){
    return '5px';
  }

  onLogClick(event: MouseEvent){
    this.clicks.push(event.timeStamp);
  }

  getBack(i: number){
    return i>=5?'blue':'white';
  }
}
