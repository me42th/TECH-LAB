import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { HandComponent } from './hand_made/hand.component';
import { StuffComponent } from './body/stuff/stuff.component';

@NgModule({
  declarations: [
    AppComponent,
    HandComponent,
    StuffComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
