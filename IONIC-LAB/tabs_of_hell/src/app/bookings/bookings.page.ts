import { Component, OnInit, ViewChild } from '@angular/core';
import { BookingService } from './booking.service';
import { Booking } from './booking.model';
import { IonItemSliding } from '@ionic/angular';
import { Places } from '../places/places.model';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-bookings',
  templateUrl: './bookings.page.html',
  styleUrls: ['./bookings.page.scss'],
})
export class BookingsPage implements OnInit {
  @ViewChild('f',{read: null,static: true}) form: NgForm;
  fck: string;

  loadedBooking: Booking[];
  places: Places = new Places(
    "p1",
    "Primeiro Lugar",
    "Um Lugar Legal",
    "https://picsum.photos/300/300",
    9,
    new Date('2019-05-02'),
    new Date('2019-12-13')

  );
  constructor(private bookingSRV: BookingService) { }

  ngOnInit() {
    this.loadedBooking = this.bookingSRV.bookings;
  }

  validateDate(){
    const dateFrom = new Date(this.form.value['date-from']);
    const endDate = new Date(this.form.value['date-to']);
    return endDate > dateFrom;
  }
  onCancel(offerid: string, slidingEl: IonItemSliding){
    slidingEl.close();
    //do something
  }

}
