import { Component, OnInit } from '@angular/core';
import { BookingService } from './booking.service';
import { Booking } from './booking.model';
import { IonItemSliding } from '@ionic/angular';

@Component({
  selector: 'app-bookings',
  templateUrl: './bookings.page.html',
  styleUrls: ['./bookings.page.scss'],
})
export class BookingsPage implements OnInit {

  loadedBooking: Booking[];
  constructor(private bookingSRV: BookingService) { }

  ngOnInit() {
    this.loadedBooking = this.bookingSRV.bookings;
  }

  onCancel(offerid: string, slidingEl: IonItemSliding){
    slidingEl.close();
    //do something
  }

}
