import { Component, OnInit } from '@angular/core';
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

  ngOnInit() {
    /*of(1, 2, 3, 4, 1, 5, 6, 4, 5)
    .pipe(
      distinctUntilChanged( (um, dois) => {
        console.log(um+' '+dois);
        return um === dois;
      } )
    ).subscribe( x => console.log(x));
    */
    console.log("____");
    of(1, 1, 2, 2, 2, 1, 1, 2, 3, 3, 4)
    .pipe(distinctUntilChanged( (um,dois) => um !== dois))
    .subscribe(x => console.log(x));

  }

}
