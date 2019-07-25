import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { RecipeService } from '../recipe.service';
import { Recipe } from '../recipe.model'; 

@Component({
  selector: 'app-detail',
  templateUrl: './detail.page.html',
  styleUrls: ['./detail.page.scss'],
})
export class DetailPage implements OnInit {

  constructor(
    private activedRoute: ActivatedRoute,
    private recipeService: RecipeService
    ) { }
  loaddedRecipe;
  ngOnInit() {
    this.activedRoute.paramMap.subscribe(
      parammap => {
        // validation
        if(!parammap.has('idrecipe'))
          return ;
        const recipeid = parammap.get('idrecipe');  
        this.loaddedRecipe = this.recipeService.getRecipe(recipeid);
      }
    );
  }

}
