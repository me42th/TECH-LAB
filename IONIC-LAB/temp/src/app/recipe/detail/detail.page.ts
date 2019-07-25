import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
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
    private recipeService: RecipeService,
    private router: Router
    ) { }
  
  loaddedRecipe: Recipe;

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

  delRecipe(){
    this.recipeService.delRecipe(this.loaddedRecipe.id);
    this.router.navigate(['/recipe']);
  }

}
