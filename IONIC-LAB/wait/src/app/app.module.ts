import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { PersonsComponent } from './persons/persons.component';
import { PersonInputComponent } from './persons/person-input.component';
//import { PersonsService } from './persons/persons.service';


@NgModule({
  declarations: [
    AppComponent, PersonsComponent, PersonInputComponent
  ],
  imports: [
    BrowserModule, FormsModule, AppRoutingModule
  ],
  //providers: [PersonsService],
  bootstrap: [AppComponent]
})
export class AppModule { }
