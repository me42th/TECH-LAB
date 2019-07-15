import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { PersonsComponent } from './persons/persons.component';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent,
    PersonsComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
