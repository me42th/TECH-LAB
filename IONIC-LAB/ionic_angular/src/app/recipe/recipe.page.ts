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
      title:'Receita de Bolo',
      imageUrl: 'https://br.recepedia.com/sites/default/files/styles/recipe_slideshow_breakpoints_theme_recepedia_desktop_1x/public/new_recepedia/recipes/images/95e9e579-3c81-4902-ad5f-115150050f40.jpg',
      ingredients: ['Farinha', 'Leite', 'Ovos']
    },
    {
      id: 'r2',
      title: 'Receita de Pão',
      imageUrl: 'https://img.itdg.com.br/tdg/images/recipes/000/002/658/277270/277270_original.jpg',
      ingredients: ['Leite','Sal','Farinha']
    },
    {
      id: 'r3',
      title: 'Receita de Macarrão',
      imageUrl: 'https://acarnequeomundoprefere.com.br/uploads/media/image/_PNK6191-macarrao-molho-linguica.jpg',
      ingredients: ['Molho','Farinha','Ovos']
    }
  ];
  constructor() { }

  ngOnInit() {
  }

}
