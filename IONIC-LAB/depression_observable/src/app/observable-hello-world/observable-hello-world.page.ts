import { Component, OnInit } from '@angular/core';
import { map, take, skipLast, skip } from 'rxjs/operators';
import { interval, pipe } from 'rxjs';

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
    console.log('thread main | start 0');
    interval(1000).pipe(
     take(12),
     skipLast(10),
     map(
      v => Date.now()
     )
    ).subscribe(
      value => {
      console.log('thread 0 | before alter');
      this.var0 = this.var0 + value + ' | ';
      console.log('thread 0 | after alter');
    });
    console.log('thread main | start 1');
    interval(1000).pipe(
      take(12),
      skip(2),
      skipLast(8),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => {
        console.log('thread 1 | before alter');
        this.var1 = this.var1 + value + ' | ';
        console.log('thread 1 | after alter');
      });
    console.log('thread main | start 2');
    interval(1000).pipe(
      take(12),
      skip(4),
      skipLast(6),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => {
        console.log('thread 2 | before alter');
        this.var2 = this.var2 + value + ' | ';
        console.log('thread 2 | after alter');
      });
    console.log('thread main | start 3');
    interval(1000).pipe(
      take(12),
      skip(6),
      skipLast(4),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => {
        console.log('thread 3 | before alter');
        this.var3 = this.var3 + value + ' | ';
        console.log('thread 3 | after alter');
      }
    );
    console.log('thread main | start 4');
    interval(1000).pipe(
      take(12),
      skip(8),
      skipLast(2),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => {
        console.log('thread 4 | before alter');
        this.var4 = this.var4 + value + ' | ';
        console.log('thread 4 | after alter');
      }
    );
    console.log('thread main | start 5');
    interval(1000).pipe(
      take(12),
      skip(10),
      map(
        v => Date.now()
      )
    ).subscribe(
      value => {
        console.log('thread 5 | before alter');
        this.var5 = this.var5 + value + ' | ';
        console.log('thread 5 | after alter');
      }
    );
  }

}
