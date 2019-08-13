import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule} from '@angular/forms';

import { AppComponent } from './app.component';
import { PersonsComponent } from './PersonsComponent/persons.component';
import { PersonsInputComponent } from './PersonsComponent/persons-input.component';

@NgModule({
  declarations: [
    AppComponent,
    PersonsComponent,
    PersonsInputComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
