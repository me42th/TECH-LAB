import { Injectable } from '@angular/core';
import { Recipe } from './recipe.model';

@Injectable({
  providedIn: 'root'
})
export class RecipeService {

  private recipes: Recipe[] =
  [
    {
      id: 'r1',
      title: 'Bolo de cereja',
      imgUrl: 'https://picsum.photos/400/400',
      ingredients: [
        'cereja',
        'farinha',
        'leite',
        'ovos'
      ]
     },
     {
       id: 'r2',
       title: 'Moqueca de siri',
       imgUrl: 'https://picsum.photos/500/500',
       ingredients: [
         'siri',
         'azeite',
         'cerveja',
         'agua'
       ]
      },
      {
       id: 'r3',
       title: 'Macarronada',
       imgUrl: 'https://picsum.photos/450/450',
       ingredients: [
         'macarrão',
         'farinha',
         'extrato',
         'oleo'
       ]
      }
 ];

  constructor() { }

  getAllRecipes(){
    return [... this.recipes];
  }

  getRecipe(recipeId: string){
    return {... this.recipes.find(recipe => {
      return recipe.id === recipeId;
    })};

  }
}
