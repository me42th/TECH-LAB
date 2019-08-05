import { Component, OnInit } from '@angular/core';
import { PlacesService } from '../places.service';
import { Places } from '../places.model';
import { MenuController } from '@ionic/angular';

@Component({
  selector: 'app-discover',
  templateUrl: './discover.page.html',
  styleUrls: ['./discover.page.scss'],
})
export class DiscoverPage implements OnInit {
  places: Places[];
  constructor(
    private placesSRV: PlacesService,
    private menuCTRL: MenuController
    ) {  }

  ngOnInit(){
    this.places = this.placesSRV.places;
  }

  onOpenMenu(){
    this.menuCTRL.toggle();
  }

}
