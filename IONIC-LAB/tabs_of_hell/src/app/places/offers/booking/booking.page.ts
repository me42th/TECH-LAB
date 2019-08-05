import { Component, OnInit } from '@angular/core';

import { Places } from "../../places.model";
import { ActivatedRoute } from "@angular/router";
import { NavController } from "@ionic/angular";
import { PlacesService } from '../../places.service';

@Component({
  selector: 'app-booking',
  templateUrl: './booking.page.html',
  styleUrls: ['./booking.page.scss'],
})
export class BookingPage  implements OnInit {
  place: Places;
  constructor(
    private route: ActivatedRoute, 
    private navCtrl: NavController,
    private placesSrv: PlacesService) {}

  ngOnInit() {
    
    this.route.paramMap.subscribe(paramMap => {
    
          
    if (!paramMap.has("placeid")) {
        this.navCtrl.navigateBack('/places/tabs/offers');
        return;
      }
      
      this.place = this.placesSrv.getPlace(paramMap.get('placeid')); 
      console.log(this.place);
      
        }); 
  }
}
