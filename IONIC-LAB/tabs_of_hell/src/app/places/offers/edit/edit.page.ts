import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NavController } from '@ionic/angular';

import { PlacesService } from '../../places.service';
import { Places } from '../../places.model';
import { FormGroup, FormControl, Validators  } from '@angular/forms';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.page.html',
  styleUrls: ['./edit.page.scss'],
})
export class EditPage implements OnInit {

  place: Places;
  form: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private placesSRV: PlacesService,
    private navCTRL: NavController 
  ) { }
    onUpdateOffer(){
      if (!this.form.valid){
        return;
      }

      console.log('click');
    }
  ngOnInit() {
    this.route.paramMap.subscribe(paramMap => {
      if (!paramMap.has('placeid')){
        this.navCTRL.navigateBack('/places/tabs/offers');
        return;
      }
      this.place = this.placesSRV.getPlace(paramMap.get('placeid'));
      this.form = new FormGroup({
        title: new FormControl(
          this.place.title, {
            updateOn: 'blur',
            validators: [Validators.required]
          }
        ) ,
        description: new FormControl(
          this.place.description, {
            updateOn: 'blur',
            validators: [Validators.required, Validators.maxLength(180)]
          })
      });
    });
  }

}
