import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { RecipeComponent } from './recipe/recipe.component';
import { HeaderComponent } from './header/header.component';
import { ListComponent } from './recipe/list/list.component';
import { DetailComponent } from './recipe/detail/detail.component';
import { ItemComponent } from './recipe/list/item/item.component';
import { EditComponent } from './shopp/edit/edit.component';
import { ShoopComponent } from './shopp/shoop.component';
import { ShoopListComponent } from './shopp/list/shoop-list.component';


@NgModule({
  declarations: [
    AppComponent,
    RecipeComponent,
    HeaderComponent,
    ListComponent,
    DetailComponent,
    ItemComponent,
    EditComponent,
    ShoopComponent,
    ShoopListComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
