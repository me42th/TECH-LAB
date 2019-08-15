import { Component, OnInit, Input } from '@angular/core';
import { Places } from '../../places.model';

@Component({
  selector: 'app-place-item',
  templateUrl: './place-item.component.html',
  styleUrls: ['./place-item.component.scss'],
})
export class PlaceItemComponent implements OnInit {

  @Input() place: Places;
  constructor() { }

  getDummyDate(){
    return new Date();
  }
  ngOnInit() {
    console.log('here'+this.place.id);

  }

}
