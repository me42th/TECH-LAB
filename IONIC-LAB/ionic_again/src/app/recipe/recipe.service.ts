import { Injectable } from '@angular/core';
import { Recipe } from './recipe.model';

@Injectable({
  providedIn: 'root'
})
export class RecipeService {
  private recipes: Recipe[] = [
    {
      id: 'r1',
      title: 'Batata',
      imgUrl: 'https://conteudo.imguol.com.br/c/entretenimento/0e/2017/10/15/batata-crua-1508077604971_v2_450x450.jpg',
      ingredients: ['Batata', 'Sal','Pimenta']
    },
    {
      id: 'r2',
      title: 'Cenoura',
      imgUrl: 'https://bs.simplusmedia.com/i/730/45/cenoura-beneficios.jpg',
      ingredients: ['Cenoura', 'Cheiro Verde','Agua']
    },
    {
      id: 'r3',
      title: 'Laranja',
      imgUrl: 'https://abrilsaude.files.wordpress.com/2017/02/laranja-alexsilva.jpg',
      ingredients: ['Laranja', 'Açucar', 'Cerveja']
    }

];

getAllRecipes(){
  return[...this.recipes];
}

getRecipe(recipeId: string){
  return this.recipes[0]; //{
    //...this.recipes.find(recipe => {
    //return recipe.id === recipeId;
  //})};
}
  constructor() { }
}
