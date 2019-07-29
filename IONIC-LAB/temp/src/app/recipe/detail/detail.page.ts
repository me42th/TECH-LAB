import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RecipeService } from '../recipe.service';
import { Recipe } from '../recipe.model'; 
import { AlertController } from '@ionic/angular';

@Component({
  selector: 'app-detail',
  templateUrl: './detail.page.html',
  styleUrls: ['./detail.page.scss'],
})
export class DetailPage implements OnInit, OnDestroy {

  constructor(
    private activedRoute: ActivatedRoute,
    private recipeService: RecipeService,
    private router: Router,
    private alertControler: AlertController
    ) { }
  
  loaddedRecipe: Recipe;

  ngOnInit() {
    console.log('NG_ON_INIT_DETAIL');
    
    this.activedRoute.paramMap.subscribe(
      parammap => {
        // validation
        if(!parammap.has('idrecipe')){
        this.router.navigate(['/recipe']);
         return ;
        }
        const recipeid = parammap.get('idrecipe');
        this.loaddedRecipe = this.recipeService.getRecipe(recipeid);
      }
    );
  }

 

  ionViewWillEnter(){
    console.log('WILL_ENTER_DETAIL');
  }

  ionViewDidEnter(){
    console.log('DID_ENTER_DETAIL');
  }
  
  ionViewWillLeave(){
    console.log('WILL_LEAVE_DETAIL');
  }

  ionViewDidLeave(){
    console.log('DID_LEAVE_DETAIL');
  }

  ngOnDestroy(){
    console.log('NG_ON_DESTROY_DETAIL');
  }

  delRecipe(){
    this.alertControler.create({
      header: 'Are you sure?',
      message: 'Do you really want to delete the recipe?',
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Delete',
          handler: () => {
            this.recipeService.delRecipe(this.loaddedRecipe.id);
            this.router.navigate(['/recipe']);
         
          }
        }
      ]
    }).then(
      alertEl => {
        alertEl.present();
      });
  }

}
