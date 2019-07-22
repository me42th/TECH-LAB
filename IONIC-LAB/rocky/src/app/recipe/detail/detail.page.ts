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

  constructor(private actRoute: ActivatedRoute, private rcpSrv: RecipeService) { }
  loadedRecipe: Recipe ;  
  flag = 'texto';
  ngOnInit() {
    this.actRoute.paramMap.subscribe(paramMap => {
      if(!paramMap.has('recipeid'))
        return;       
      const recipeid = paramMap.get('recipeid');
      this.loadedRecipe = this.rcpSrv.getRecipe(recipeid);
      
          
    });
    
    
  }

}
