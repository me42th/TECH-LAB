import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { DistinctUntilChangePage } from './distinct-until-change.page';

const routes: Routes = [
  {
    path: '',
    component: DistinctUntilChangePage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  declarations: [DistinctUntilChangePage]
})
export class DistinctUntilChangePageModule {}
