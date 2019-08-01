import { Component, OnInit } from '@angular/core';
import { PlacesService } from '../places.service';
import { Place } from '../place.model';

@Component({
  selector: 'app-discovery',
  templateUrl: './discovery.page.html',
  styleUrls: ['./discovery.page.scss'],
})
export class DiscoveryPage implements OnInit {

  loadedPlaces: Place[];
  constructor(private placesSRVC: PlacesService) { }

  ngOnInit() {
    
    
    
  }

}
