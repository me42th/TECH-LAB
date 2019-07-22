import { Component, OnInit } from '@angular/core';
import { Recipe } from './recipe.model';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.page.html',
  styleUrls: ['./recipe.page.scss'],
})
export class RecipePage implements OnInit {

  recipes: Recipe[];

  constructor() { }

  ngOnInit() {
    this.recipes = [
      {
        id: 'r1',
        title: 'Morango Stuff',
        imgURL: 'https://www.mercafruty.com.br/wp-content/uploads/2016/08/morango-fruta.jpg',
        ingredients: ['Morango', 'Stuff','Recipe']
    },
    {
      id: 'r2',
      title: 'Banana Thing',
      imgURL: 'https://mambo.vteximg.com.br/arquivos/ids/188636/131506.jpg?v=635920946752830000',
      ingredients: ['Banana','Thing','Recipe'] 
    },
    {
      id: 'r3',
      title: 'Abacate Roots',
      imgURL: 'https://abrilsaude.files.wordpress.com/2016/10/abacate-57279.jpg?quality=85&strip=info&resize=680,453',
      ingredients: ['Abacate', 'Roots','Recipe']
    }
    ];
  }

}
