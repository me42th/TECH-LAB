import { Component, OnInit } from '@angular/core';
import { interval } from 'rxjs';
import { take, map, tap } from 'rxjs/operators';

@Component({
  selector: 'app-meeting',
  templateUrl: './meeting.page.html',
  styleUrls: ['./meeting.page.scss'],
})
export class MeetingPage implements OnInit {

  constructor() { }

  ngOnInit() {
    interval(1000).pipe(
      take(3),
      map( value => 'David' )
    ).subscribe(
      next => console.log(next)
    );
  }

}
