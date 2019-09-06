import { Component, OnInit } from '@angular/core';
import { map, take } from "rxjs/operators";
import { interval, pipe } from "rxjs";

@Component({
  selector: 'app-observable-hello-world',
  templateUrl: './observable-hello-world.page.html',
  styleUrls: ['./observable-hello-world.page.scss'],
})
export class ObservableHelloWorldPage implements OnInit {

  obsVar: string = ' |';
  constructor() { }

  ngOnInit() {
    
  }

  onClick(){
   
    interval(1000).pipe(
      take(100),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => this.obsVar = this.obsVar + value + ' |'
    );
  }

}
