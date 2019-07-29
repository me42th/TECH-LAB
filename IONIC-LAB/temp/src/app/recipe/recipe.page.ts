import { Component, OnInit, OnDestroy } from '@angular/core';
import { Recipe } from './recipe.model';
import { RecipeService } from './recipe.service';


@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.page.html',
  styleUrls: ['./recipe.page.scss'],
})

export class RecipePage implements OnInit, OnDestroy {
  recipes: Recipe[];

  constructor(
    private rcpSrv: RecipeService,
    ) { }

  ngOnInit() {
    this.recipes = this.rcpSrv.getAllRecipes();
    console.log('NG_ON_INIT_RECIPE');
    console.log(this.recipes);
  }

  ionViewWillEnter(){
    console.log('WILL_ENTER_RECIPE');
  }

  ionViewDidEnter(){
    console.log('DID_ENTER_RECIPE');
  }
  
  ionViewWillLeave(){
    console.log('WILL_LEAVE_RECIPE');
  }

  ionViewDidLeave(){
    console.log('DID_LEAVE_RECIPE');
  }

  ngOnDestroy(){
    console.log('NG_ON_DESTROY_RECIPE');
  }
}
