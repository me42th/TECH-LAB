import { Component, OnInit } from '@angular/core';
import { PlacesService } from '../places.service';
import { Places } from '../places.model';
import { MenuController, IonItemSliding } from '@ionic/angular';
import { Router } from '@angular/router';

@Component({
  selector: 'app-discover',
  templateUrl: './discover.page.html',
  styleUrls: ['./discover.page.scss'],
})

export class DiscoverPage implements OnInit {
  places: Places[];
  constructor(
    private placesSRV: PlacesService,
    private menuCTRL: MenuController,
    private router: Router
    ) {  }

  ngOnInit(){
    this.places = this.placesSRV.places;
  }

  ionViewWillEnter(){
    this.places = this.placesSRV.places;
  }
  onEdit(func: string, id: string, sliding: IonItemSliding){
    sliding.close();
    console.log(func+' | '+id+' G12');
    this.router.navigate(['/','places','tabs','discover',id]);

  }

  onOpenMenu(){
    this.menuCTRL.toggle();
  }

}
