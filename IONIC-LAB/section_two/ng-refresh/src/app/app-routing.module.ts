import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonsComponent } from './PersonsComponent/persons.component';
import { PersonsInputComponent } from './PersonsComponent/persons-input.component';

const routes: Routes = [
  {path: '', component: PersonsComponent},
  {path: 'input', component: PersonsInputComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
