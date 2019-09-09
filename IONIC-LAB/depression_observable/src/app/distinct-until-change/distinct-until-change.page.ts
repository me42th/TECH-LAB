import { Component, OnInit, EventEmitter } from '@angular/core';
import { interval, of } from 'rxjs';
import { distinctUntilChanged } from 'rxjs/operators';

@Component({
  selector: 'app-distinct-until-change',
  templateUrl: './distinct-until-change.page.html',
  styleUrls: ['./distinct-until-change.page.scss'],
})
export class DistinctUntilChangePage implements OnInit {

  constructor() { }
  stream: number[] = [1, 2, 3, 4, 1, 5, 6, 4, 5];
  emissor = new EventEmitter<number>();

  ngOnInit() {
    of(1, 1, 2, 2, 2, 1, 1, 2, 3, 3, 4)
    .pipe(distinctUntilChanged( (um, dois) => um !== dois))
    .subscribe(x => this.emissor.emit(1) );

    this.emissor.subscribe(x =>  console.log('inside emissor ') );
  }

}
