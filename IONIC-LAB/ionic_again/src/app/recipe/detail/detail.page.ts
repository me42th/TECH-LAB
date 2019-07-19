import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import { RecipeService } from '../recipe.service';
import { Recipe } from '../recipe.model';

@Component({
  selector: 'app-detail',
  templateUrl: './detail.page.html',
  styleUrls: ['./detail.page.scss'],
})
export class DetailPage implements OnInit {

  loadedRecipe: Recipe;
  id;

  constructor(private activatedRoute: ActivatedRoute, private rcpService: RecipeService) { }

  ngOnInit() {
  this.activatedRoute.paramMap.subscribe(paramMap =>{
    if(!paramMap.has('recipeId')){
      //redirect
      return;
    }
    const recipeId = paramMap.get('recipeId');
    this.id = recipeId;
    this.loadedRecipe = this.rcpService.getRecipe(recipeId);
  });
  }

}
