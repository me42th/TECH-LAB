import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { HeaderComponent } from './header/header.component';
import { ShoppingListComponent } from './shoppinglist/shopping-list/shopping-list.component';
import { ShoppingListEditComponent } from './shoppinglist/shopping-list-edit/shopping-list-edit.component';
import { RecipeBookListComponent } from './recipebook/recipe-book-list/recipe-book-list.component';
import { RecipeBookItemComponent } from './recipebook/recipe-book-item/recipe-book-item.component';
import { RecipeBookDetailComponent } from './recipebook/recipe-book-detail/recipe-book-detail.component';
import { ShoppinglistComponent } from './shoppinglist/shoppinglist.component';
import { RecipebookComponent } from './recipebook/recipebook.component';
@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    ShoppingListComponent,
    ShoppingListEditComponent,
    RecipeBookListComponent,
    RecipeBookItemComponent,
    RecipeBookDetailComponent,
    ShoppinglistComponent,
    RecipebookComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
