import { Component, OnInit } from "@angular/core";
import { Router } from "@angular/router";
import { NavController, ModalController } from "@ionic/angular";
import { CreateBookingComponent } from '../../../bookings/create-booking/create-booking.component';

@Component({
  selector: "app-details",
  templateUrl: "./details.page.html",
  styleUrls: ["./details.page.scss"]
})
export class DetailsPage implements OnInit {
  constructor(
    private router: Router,
    private navCtrl: NavController,
    private modalCTRL: ModalController
  ) {}

  ngOnInit() {}

  onBookPlace() {
    //this.router.navigateByUrl('/places/tabs/discover');
    //this.navCtrl.navigateBack('/places/tabs/discover');
    //this.navCtrl.pop();
    this.modalCTRL.create({component: CreateBookingComponent})
    .then(
      modalEl => {
        modalEl.present();
      }
      );
  }
}
