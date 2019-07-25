import { Component, OnInit } from '@angular/core';
import { Recipe } from './recipe.model';
import { RecipeService } from './recipe.service';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.page.html',
  styleUrls: ['./recipe.page.scss'],
})
export class RecipePage implements OnInit {

  recipes: Recipe[];
  rcp: Recipe;

  constructor(private rcpSrv: RecipeService) { }

  ngOnInit() {
    this.recipes = this.rcpSrv.getAllRecipes();
    console.log(this.recipes);
    this.rcp = this.rcpSrv.getRecipe('r1');
  }

}
