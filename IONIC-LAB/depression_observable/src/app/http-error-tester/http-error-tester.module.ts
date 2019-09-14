import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { HttpErrorTesterPage } from './http-error-tester.page';

const routes: Routes = [
  {
    path: '',
    component: HttpErrorTesterPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  declarations: [HttpErrorTesterPage]
})
export class HttpErrorTesterPageModule {}
