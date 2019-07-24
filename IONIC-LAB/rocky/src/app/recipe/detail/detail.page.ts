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
    private actRoute: ActivatedRoute, 
    private rcpSrv: RecipeService, 
    private router: Router,
    private alertCtrl: AlertController) { }
  loadedRecipe: Recipe ;
  flag = 'texto';

  ngOnInit() {
    this.actRoute.paramMap.subscribe(paramMap => {
      if(!paramMap.has('recipeid'))
        return;
      const recipeid = paramMap.get('recipeid');
      this.loadedRecipe = this.rcpSrv.getRecipe(recipeid);
    });

  }

  onDelRecipe(){
    
    this.alertCtrl.create(
      {
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
              this.rcpSrv.delRecipe(this.loadedRecipe.id);
              this.router.navigate(['/recipe']);
            }
          }
        ] 
      }).then( 
        alertEl => {
          alertEl.present();
        }
      );
  }
}
