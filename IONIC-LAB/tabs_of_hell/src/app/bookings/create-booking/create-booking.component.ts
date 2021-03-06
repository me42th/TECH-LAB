import { Component, OnInit, Input } from '@angular/core';
import { Places } from '../../places/places.model';

@Component({
  selector: 'app-create-booking',
  templateUrl: './create-booking.component.html',
  styleUrls: ['./create-booking.component.scss'],
})
export class CreateBookingComponent implements OnInit {
  @Input() selectedPlace: Places;
  constructor() { }

  ngOnInit() {}

}
