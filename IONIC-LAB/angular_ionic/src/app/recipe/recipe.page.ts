import { Component, OnInit } from '@angular/core';
import { Recipe } from './recipe.model';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.page.html',
  styleUrls: ['./recipe.page.scss'],
})
export class RecipePage implements OnInit {
  recipes: Recipe[] = [
    {
      id: 'r1', 
      title: 'Receita', 
      imageUrl: 'url',
      ingredients: ['Agua','Cerveja','Farinha']
    },
    {
      id: 'r2', 
      title: 'Outra Receita', 
      imageUrl: 'url',
      ingredients: ['Agua','Cerveja','Farinha']
    },
    {
      id: 'r3', 
      title: 'Mais Uma Receita', 
      imageUrl: 'url',
      ingredients: ['Agua','Cerveja','Farinha']
    }
  ]; 
  constructor() { }

  ngOnInit() {
  }

}
