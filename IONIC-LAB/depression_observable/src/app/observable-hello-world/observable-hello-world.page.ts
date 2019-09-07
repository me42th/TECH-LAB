import { Component, OnInit } from '@angular/core';
import { map, take, skipLast, skip } from "rxjs/operators";
import { interval, pipe } from "rxjs";

@Component({
  selector: 'app-observable-hello-world',
  templateUrl: './observable-hello-world.page.html',
  styleUrls: ['./observable-hello-world.page.scss'],
})
export class ObservableHelloWorldPage implements OnInit {

  var0 = ' ';
  var1 = ' ';
  var2 = ' ';
  var3 = ' ';
  var4 = ' ';
  var5 = ' ';
  
  constructor() { }

  ngOnInit() {
  }

  onClick() {
    console.log('a');
    interval(1000).pipe(
     take(12),
     skipLast(10),
     map(
      v => Date.now()
     )
    ).subscribe(
      value => this.var0 = this.var0 + value + ' | '
    );
    interval(1000).pipe(
      take(12),
      skip(2),
      skipLast(8),
      map(
        v => Date.now()
      )
    ).subscribe(
       value => this.var1 = this.var1 + value + ' | '
    );
    interval(1000).pipe(
      take(12),
      skip(4),
      skipLast(6),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => this.var2 = this.var2 + value + ' | '
    );
    interval(1000).pipe(
      take(12),
      skip(6),
      skipLast(4),
      map( 
        v => Date.now()
      )
    ).subscribe(
      value => this.var3 = this.var3 + value + ' | '
    );
    interval(1000).pipe(
      take(12),
      skip(8),
      skipLast(2),
      map( 
        v => Date.now()
      )
    ).subscribe(
      value => this.var4 = this.var4 + value + ' | '
    );
    interval(1000).pipe(
      take(12),
      skip(10),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => this.var5 = this.var5 + value + ' | '
    );
  }

}
