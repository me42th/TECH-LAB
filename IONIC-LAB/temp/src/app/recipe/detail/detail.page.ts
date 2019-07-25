import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RecipeService } from '../recipe.service';
import { Recipe } from '../recipe.model'; 
import { AlertController } from '@ionic/angular';

@Component({
  selector: 'app-detail',
  templateUrl: './detail.page.html',
  styleUrls: ['./detail.page.scss'],
})
export class DetailPage implements OnInit {

  constructor(
    private activedRoute: ActivatedRoute,
    private recipeService: RecipeService,
    private router: Router,
    private alertControler: AlertController
    ) { }
  
  loaddedRecipe: Recipe;

  ngOnInit() {
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
