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
  showSecret = false;
  content = 'Display';

  constructor() { }

  ngOnInit(): void {
  }

  getMargin(){
    return '5px';
  }

  onLogClick(event: MouseEvent){
    this.showSecret = !this.showSecret;
    this.content = this.showSecret?'Hidden':'Display';
    this.clicks.push(new Date());
  }

  getBack(i: number){
    return i>=4?'blue':'white';
  }
}
