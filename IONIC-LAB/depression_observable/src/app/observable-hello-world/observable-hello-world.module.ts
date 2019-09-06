import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { ObservableHelloWorldPage } from './observable-hello-world.page';

const routes: Routes = [
  {
    path: '',
    component: ObservableHelloWorldPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  declarations: [ObservableHelloWorldPage]
})
export class ObservableHelloWorldPageModule {}
