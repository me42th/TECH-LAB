import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'recipe', pathMatch: 'full' },

  { 
    path: 'recipe', 
    children: [
      {path: '', loadChildren: './recipe/recipe.module#RecipePageModule'},
      {path: ':recipeid', loadChildren: './recipe/detail/detail.module#DetailPageModule' }
    ]
     
  }
  //{ path: 'detail',  },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
