import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { WarningComponent } from './warning/warning.component';
import { AppComponent } from './app.component';
import { SuccessComponent } from './success/success.component';

@NgModule({
  declarations: [
    AppComponent,
    WarningComponent,
    SuccessComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
